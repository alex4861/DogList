//
//  MockListView.swift
//  DogList
//
//  Created by Alejandro Rodriguez on 06/06/25.
//
import UIKit
@testable import DogList

// MARK: - Mock Classes

// MARK: - Mock ListView Implementation
final class MockListView: ListViewProtocol {

    var presenter: ListPresenterProtocol?
    var reloadCalled = false
    var mockCell: MockTableViewCell = MockTableViewCell()
    var errorImage: UIImage? = UIImage(named: "ErrorImage")
    func configureImage(_ image: UIImage?, cell: ListCell, indexPath: IndexPath) {
        cell.configureImage(image, indexPath: indexPath)
    }
    func reloadTableView() { reloadCalled = true }
    func configureErrorImage(cell: DogList.ListCell, indexPath: IndexPath) {
        cell.configureImage(errorImage, indexPath: indexPath)
    }
}

// MARK: - Mock Interactor Implementation
final class MockListInteractor: ListInteractorInputProtocol {

    var presenter: ListInteractorOutputProtocol?
    var shouldFail = false

    func getDogList() async throws {
        if shouldFail {
            throw DogListError.description("Simulated failure")
        }
    }

    func loadImage(from url: URL) async throws -> UIImage {
        if shouldFail {
            throw DogListError.description("Simulated image load failure")
        }
        return UIImage()
    }

}

// MARK: - Mock Router Implementation
final class MockListRouter: ListRouterProtocol {
    var didGoBack = false
    var didGoNext = false
    func goBack() { didGoBack = true }

    func goToNextModule() { didGoNext = true }
}

// MARK: - Mock Service and Database Managers
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

    func save(entities: [DogList.DogEntity]) async throws {
        if shouldFail {
            throw error
        }
        savedEntities = entities
    }
    
    func getSavedEntities() async throws -> [DogList.DogEntity] {
        if shouldFail {
            throw DogListError.description("Simulated fetch failure")
        }
        return savedEntities
    }

}

final class MockUserDefaults: UserDefaults {
    var storage: [String: Any] = [:]

    override func bool(forKey defaultName: String) -> Bool {
        return storage[defaultName] as? Bool ?? false
    }

    override func set(_ value: Any?, forKey defaultName: String) {
        storage[defaultName] = value
    }
}

// MARK: - Mock Presenter Implementation
final class MockPresenter: ListInteractorOutputProtocol {
    var receivedDogs: [DogEntity] = []

    func fillData(items: [DogEntity]) {
        receivedDogs = items
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

final class MockTableViewCell: ListCell {
    var indexPath: IndexPath?

    var imgDog: UIImage?
    var data: DogList.DogEntity?

    func configure(with data: DogList.DogEntity, indexPath: IndexPath?) {
        self.data = data
        self.indexPath = indexPath
    }

    func configureImage(_ image: UIImage?, indexPath: IndexPath?) {
        self.imgDog = image
    }

}
