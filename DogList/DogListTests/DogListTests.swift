//
//  DogListTests.swift
//  DogListTests
//
//  Created by Alejandro Rodriguez on 06/06/25.
//

import Testing
@testable import DogList
import UIKit

@Suite("DogList Tests")
final class DogListTests {

    let mockEntities = [
        DogEntity(id: "1", dogName: "Big Mac", description: "A dog", age: 2, image: ""),
        DogEntity(id: "2", dogName: "Tofi", description: "A little dog", age: 3, image: ""),
        DogEntity(id: "3", dogName: "Duffi", description: "A big dog", age: 3, image: ""),
        DogEntity(id: "4", dogName: "Maolani", description: "A older dog", age: 9, image: "")
    ]
    let commonDog = DogEntity(dogName: "Big Mac", description: "A dog", age: 2, image: "")
    let url = URL(string: "https://jsonblob.com/api/1151549092634943488")!

    @Test("Check Number Of Rows")
    func checkNumberOfRows() async throws {
        let view = MockListView()
        let presenter = ListPresenter(view: view)
        presenter.fillData(items: mockEntities)
        #expect(presenter.numberOfRows() == 4)
    }

    @Test("Return correct Model")
    func returnCorrectModel() async throws {
        let presenter = ListPresenter()
        presenter.fillData(items: mockEntities)
        let dogData = presenter.getCellData(for: IndexPath(row: 0, section: 0))
        #expect(dogData?.dogName ==  commonDog.dogName)
    }

    @Test("Is first Time")
    func checkIfIsFirstTime() async throws {
        let serviceManager = MockServiceManager()
        let databaseManager = MockDatabase()
        let userDefaults = MockUserDefaults()
        let presenter = MockPresenter()

        serviceManager.mockObject = mockEntities
        let interactor = ListInteractor(serviceManager: serviceManager,
                                        databaseManager: databaseManager,
                                        userDefault: userDefaults,
                                        url: url)
        interactor.presenter = presenter
        try await interactor.getDogList()
        #expect(presenter.receivedDogs.count == mockEntities.count)
        #expect(userDefaults.storage["isNotFirstLogin"] as? Bool == true)
    }

    @Test("Is not first time, loads from DB only")
    func checkIfIsNotFirstTime() async throws {
        let database = MockDatabase()
        database.savedEntities = mockEntities
        let userDefaults = MockUserDefaults()
        userDefaults.storage["isNotFirstLogin"] = true
        let presenter = MockPresenter()

        let interactor = ListInteractor(serviceManager: MockServiceManager(),
                                        databaseManager: database,
                                        userDefault: userDefaults,
                                        url: url)
        interactor.presenter = presenter

        try await interactor.getDogList()
        #expect(presenter.receivedDogs.count == 4)
    }

    @Test("View reloads when presenter fills data")
    func viewReloadsWhenPresenterFillsData() async throws {
        let view = MockListView()
        let presenter = ListPresenter(view: view,
                                      interactor: nil,
                                      router: nil)
        presenter.fillData(items: mockEntities)
        #expect(view.reloadCalled == true)
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

    @Test("Image downsampling works correctly")
    func imageDownsamplingWorksCorrectly() async throws {
        let data = UIImage(named: "ErrorImage")?.pngData() ?? Data()
        let downsampledImage = UIImage(data: data, maxDimension: 480) ?? UIImage()
        #expect(downsampledImage.size.width <= 480)
        #expect(downsampledImage.size.height <= 480)
    }

    @Test("Image error loading works correctly")
    func imageErrorLoadingWorksCorrectly() async throws {
        let interactor = MockListInteractor()
        interactor.shouldFail = true
        let view = MockListView()
        let cell = MockTableViewCell()
        let indexPath = IndexPath(row: 0, section: 0)
        cell.indexPath = indexPath
        view.mockCell = cell
        view.errorImage = UIImage(named: "ErrorImage") ?? UIImage()
        let presenter = ListPresenter(view: view, interactor: interactor)
        await presenter.loadImage(from: url, cell: view.mockCell, indexPath: indexPath).value
        #expect(view.mockCell.imgDog?.pngData() == view.errorImage?.pngData())
    }

    @Test("Image error loading works correctly in ViewController")
    @MainActor
    func imageErrorLoadingInViewController() async throws {
        let viewController = ListViewController()
        let cell = MockTableViewCell()
        let indexPath = IndexPath(row: 0, section: 0)

        // Forzar la carga de la vista si no está cargada
        _ = viewController.view

        viewController.configureErrorImage(cell: cell, indexPath: indexPath)

        let expectedImage = UIImage(named: "ErrorImage")?.pngData()
        let actualImage = cell.imgDog?.pngData()
        #expect(expectedImage == actualImage)
    }

}
