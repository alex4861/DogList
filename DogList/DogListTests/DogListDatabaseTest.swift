//
//  DogListDatabaseTest.swift
//  DogList
//
//  Created by Alejandro Rodriguez on 06/06/25.
//

import Testing
@testable import DogList
import UIKit

@Suite("Test for Database operations")
final class DogListRealmTest {

    let mockEntities = [
        DogEntity(id: "1", dogName: "Big Mac", description: "A dog", age: 2, image: ""),
        DogEntity(id: "2", dogName: "Tofi", description: "A little dog", age: 3, image: ""),
        DogEntity(id: "3", dogName: "Duffi", description: "A big dog", age: 3, image: ""),
        DogEntity(id: "4", dogName: "Maolani", description: "A older dog", age: 9, image: "")
    ]

    let commonDog = DogEntity(dogName: "Big Mac", description: "A dog", age: 2, image: "")

    let url = URL(string: "https://jsonblob.com/api/1151549092634943488")!


    @Test("Database failure prevents storage")
    func databaseFailurePreventsStorage() async throws {
        let serviceManager = MockServiceManager()
        serviceManager.mockObject = mockEntities
        let database = MockDatabase()
        database.shouldFail = true
        let userDefaults = MockUserDefaults()
        let presenter = MockPresenter()

        let interactor = ListInteractor(serviceManager: serviceManager,
                                        databaseManager: database,
                                        userDefault: userDefaults,
                                        url: url)
        interactor.presenter = presenter
        await #expect(throws: database.error) {
            try await interactor.getDogList()
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

