//
//  DogListServiceTest.swift
//  DogList
//
//  Created by Alejandro Rodriguez on 06/06/25.
//

import Testing
@testable import DogList
import UIKit

@Suite("Test for Services operations")
final class DogListServiceTest {

    let mockEntities = [
        DogEntity(id: "1", dogName: "Big Mac", description: "A dog", age: 2, image: ""),
        DogEntity(id: "2", dogName: "Tofi", description: "A little dog", age: 3, image: ""),
        DogEntity(id: "3", dogName: "Duffi", description: "A big dog", age: 3, image: ""),
        DogEntity(id: "4", dogName: "Maolani", description: "A older dog", age: 9, image: "")
    ]

    let commonDog = DogEntity(dogName: "Big Mac", description: "A dog", age: 2, image: "")

    let url = URL(string: "https://jsonblob.com/api/1151549092634943488")!

    @Test("Load data from service")
    func loadDataFromService() async throws {
        let serviceManager = MockServiceManager()
        serviceManager.mockObject = commonDog
        let response = try await serviceManager.getData(from: url,
                                                        responseType: DogEntity.self)
        #expect(response.dogName == commonDog.dogName)
    }

    @Test("URL doen't exist formatted")
    func urlIncorrectlyFormatted() async throws {
        let serviceManager = MockServiceManager()
        let interactor = ListInteractor(serviceManager: serviceManager,
                                        databaseManager: MockDatabase(),
                                        userDefault: MockUserDefaults(),
                                        url: nil)
        await #expect(throws: DogListError.description("Bad URL".localized)) {
            try await interactor.getDogList()
        }
    }

    @Test("Service failure does not store data")
    func serviceFailureDoesNotStoreData() async throws {
        let serviceManager = MockServiceManager()
        serviceManager.shouldFail = true
        let database = MockDatabase()
        let userDefaults = MockUserDefaults()
        let interactor = ListInteractor(serviceManager: serviceManager,
                                        databaseManager: database,
                                        userDefault: userDefaults,
                                        url: url)
        await #expect(throws: serviceManager.error) {
            try await interactor.getDogList()
        }
    }

    @Test("Service Failure fill empty data")
    func serviceFailureFillEmptyData() async throws {
        let interactor = MockListInteractor()
        interactor.shouldFail = true
        let presenter = ListPresenter(interactor: interactor)
        await presenter.getDogList().value
        #expect(presenter.numberOfRows() == 0)
    }

    @Test("URL Session gets data correctly")
    func urlSessionGetsDataCorrectly() async throws {
        let session = MockSession()
        session.mockData = try JSONEncoder().encode(mockEntities)
        let serviceRequest = ServiceRequest(session: session)
        let result = try await serviceRequest.getData(from: url, responseType: [DogEntity].self)
        #expect(result.count == mockEntities.count)
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

}

