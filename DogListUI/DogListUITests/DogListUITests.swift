//
//  DogListUITests.swift
//  DogListUITests
//
//  Created by Alejandro Rodriguez on 06/06/25.
//

import Testing
import Foundation
@testable import DogListUI

@Suite("DogListUITests")
final class DogListUITests {

    let mockEntities: [DogEntity] = [
        DogEntity(id: "1", dogName: "Big Mac", description: "A dog", age: 2, image: ""),
        DogEntity(id: "2", dogName: "Tofi", description: "A little dog", age: 3, image: ""),
        DogEntity(id: "3", dogName: "Duffi", description: "A big dog", age: 3, image: ""),
        DogEntity(id: "4", dogName: "Maolani", description: "An older dog", age: 9, image: "")
       ]
    let commonDog = DogEntity(dogName: "Big Mac", description: "A dog", age: 2, image: "")
    let url = URL(string: "https://jsonblob.com/api/1151549092634943488")!

    @Test("Check Number Of Elements")
    func checkNumberOfElements() async throws {
        let viewModel = MockViewModel(serviceManager: MockServiceManager(),
                                        databaseManager: MockDatabase(),
                                      userDefaults: MockUserDefaults(),
                                      url: url)

            viewModel.items = mockEntities
        try await viewModel.fecthDogs()
        #expect(viewModel.items.count == 4, "Expected 4 items, but got \(viewModel.items.count)")
    }

    @Test("Check If is First Time")
    func checkIfIsFirstTime() async throws {
        let userDefaults = MockUserDefaults()
        userDefaults.set(false, forKey: "isNotFirstLogin")
        let serviceManager = MockServiceManager()
        serviceManager.mockObject = mockEntities
        let viewModel = ViewModel(serviceManager: serviceManager,
                                  databaseManager: MockDatabase(),
                                  userDefaults: userDefaults,
                                  url: url)
        try await viewModel.fecthDogs()
        #expect(userDefaults.bool(forKey: "isNotFirstLogin") == true)
    }

    @Test("Is not first time, loads from DB only")
    func isNotFirstTimeLoadsFromDB() async throws {
        let database = MockDatabase()
        database.savedEntities = mockEntities
        let userDefaults = MockUserDefaults()
        userDefaults.set(true, forKey: "isNotFirstLogin")
        let viewModel = ViewModel(serviceManager: MockServiceManager(),
                                  databaseManager: database,
                                  userDefaults: userDefaults,
                                  url: url)
        try await viewModel.fecthDogs()
        #expect(viewModel.items.count == mockEntities.count)
    }

    @Test("Returns decoded object from mockObject")
    func testGetDataDecodesCorrectly() async throws {
        let session = MockSession()
        session.mockData = try JSONEncoder().encode(mockEntities)
        let serviceManager = ServiceRequest(session: session)

        let result = try await serviceManager.getData(from: url, responseType: [DogEntity].self)

        #expect(result.count == mockEntities.count)
        #expect(result[0].dogName == commonDog.dogName)
        #expect(result[0].description == commonDog.description)
        #expect(result[0].age == commonDog.age)
        #expect(result[0].image == commonDog.image)
    }

    @Test("Load data from service")
    func loadDataFromService() async throws {
        let session = MockSession()
        let serviceManager = MockServiceManager()
        serviceManager.session = session
        serviceManager.mockObject = mockEntities
        let response = try await serviceManager.getData(from: url, responseType: [DogEntity].self)
        #expect(response[0].dogName == commonDog.dogName)
    }

    @Test("URL Session gets raw data correctly")
    func testRawGetData() async throws {
        let data = "mocked".data(using: .utf8)!
        let session = MockSession()
        session.mockData = data
        let service = ServiceRequest(session: session)
        let result = try await service.getData(from: url)
        #expect(result == data)
    }

    @Test("URL doen't exist formatted")
    func urlIncorrectlyFormatted() async throws {
        let serviceManager = MockServiceManager()
        let viewModel = ViewModel(serviceManager: serviceManager,
                                   databaseManager: MockDatabase(),
                                   userDefaults: MockUserDefaults(),
                                   url: nil)
        await #expect(throws: DogListError.description("Bad URL")) {
            try await viewModel.fecthDogs()
        }
    }

    @Test("Service failure does not store data")
    func serviceFailureDoesNotStoreData() async throws {
        let serviceManager = MockServiceManager()
        serviceManager.shouldFail = true
        let viewModel = ViewModel(serviceManager: serviceManager,
                                   databaseManager: MockDatabase(),
                                   userDefaults: MockUserDefaults(),
                                   url: url)
        await #expect(throws: serviceManager.error) {
            try await viewModel.fecthDogs()
        }
    }

    @Test("Fails decoding with invalid JSON")
    func decodingFailsWithInvalidJSON() async throws {
        let session = MockSession()
        session.error = .description("Invalid JSON")
        session.shouldFail = true
        session.mockData = "Invalid JSON".data(using: .utf8)!
        let serviceRequest = ServiceRequest(session: session)
        let mockURL = URL(string: "https://example.com/image.png")!
        await #expect(throws: session.error) {
            try await serviceRequest.getData(from: mockURL, responseType: [DogEntity].self)
        }
    }

    @Test("Database failure prevents storage")
    func databaseFailurePreventsStorage() async throws {
        let serviceManager = MockServiceManager()
        serviceManager.mockObject = mockEntities
        let database = MockDatabase()
        database.shouldFail = true
        let userDefaults = MockUserDefaults()
        let viewModel = ViewModel(serviceManager: serviceManager,
                                   databaseManager: database,
                                   userDefaults: MockUserDefaults(),
                                   url: url)
        await #expect(throws: database.error) {
            try await viewModel.fecthDogs()
        }
        #expect(userDefaults.storage["isNotFirstLogin"] == nil)
    }

    @Test("Conversion to Dog database model works correctly")
    func testToDatabaseModel() {
        let dog = commonDog.toDatabaseModel()
        #expect(dog.dogName == commonDog.dogName)
        #expect(dog.dogDescription == commonDog.description)
        #expect(dog.age == commonDog.age)
        #expect(dog.image == commonDog.image)
    }

    @Test("Realm saves DogEntity correctly")
    func realmSavesDogEntity() async throws {

        let db = Database(identifier: "TestDB")
        try await db.save(entities: mockEntities)

        let entities = try await db.getSavedEntities()
        #expect(entities.count == mockEntities.count)
        #expect(entities.first?.dogName == commonDog.dogName)
    }

    @Test("Load data from database")
    func loadDataFromDatabase() async throws {
        let databaseManager = MockDatabase()
        try await databaseManager.save(entities: mockEntities)
        let result = try await databaseManager.getSavedEntities()
        #expect(result.count == 4)
        #expect(result.first?.dogName == commonDog.dogName)
    }


}
