//
//  MockEnities.swift
//  DogListUI
//
//  Created by Alejandro Rodriguez on 06/06/25.
//

import Foundation
@testable import DogListUI

// MARK: - Mock ViewModel implementation.
final class MockViewModel: ViewModelProtocol {
    var items: [DogListUI.DogEntity] = []

    var url: URL?

    var serviceManager: DogListUI.ServiceManager

    var databaseManager: DogListUI.DatabaseManager

    var userDefaults: UserDefaults

    func fecthDogs() async throws {}

    init(serviceManager: DogListUI.ServiceManager,
         databaseManager: DogListUI.DatabaseManager,
         userDefaults: UserDefaults,
         url: URL?) {
        self.serviceManager = serviceManager
        self.databaseManager = databaseManager
        self.userDefaults = userDefaults
        self.url = url
    }

}

// MARK: - Mock implementations ServiceManager protocols.
final class MockServiceManager: ServiceManager {

    var session: Session = MockSession()

    var shouldFail = false
    var mockObject: Any?
    var mockData: Data?
    var error: DogListError = .description("Simulated service error")

    func getData(from url: URL) async throws -> Data {
        if shouldFail {
            throw DogListError.description("Simulated error")
        }
        return mockData ?? Data()
    }

    func getData<T>(from url: URL, responseType: T.Type) async throws -> T where T : Decodable, T : Encodable {
        if shouldFail { throw error }
        if let mockObject = mockObject as? T {
            return mockObject
        } else {
            throw DogListError.description("Invalid cast in mock")
        }
    }


}
// MARK: - Mock Database and UserDefaults
final class MockDatabase: DatabaseManager {

    var shouldFail = false
    var savedEntities: [DogEntity] = []
    var error: DogListError = .description("Simulated database error")

    func save(entities: [DogListUI.DogEntity]) async throws {
        if shouldFail {
            throw error
        }
        savedEntities = entities
    }

    func getSavedEntities() async throws -> [DogListUI.DogEntity] {
        if shouldFail {
            throw DogListError.description("Simulated fetch failure")
        }
        return savedEntities
    }

}

// MARK: - Mock UserDefaults implementation.
final class MockUserDefaults: UserDefaults {
    var storage: [String: Any] = [:]

    override func bool(forKey defaultName: String) -> Bool {
        return storage[defaultName] as? Bool ?? false
    }

    override func set(_ value: Any?, forKey defaultName: String) {
        storage[defaultName] = value
    }
}

final class MockSession: Session {
    var mockData: Data = Data()
    var shouldFail = false
    var error: DogListError = .description("Simulated session error")
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if shouldFail {
            throw error
        }
        return (mockData, URLResponse())
    }
}
