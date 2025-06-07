//
//  ListRouter.swift
//  DogList
//
//  Created Alejandro Rodriguez on 06/06/25.
//  Copyright © 2025. All rights reserved.
//
//

import UIKit

final class ListRouter {

    // MARK: - Variables

    weak var view: ListViewController!

    // MARK: - Functions

    static func createModule(serviceManager: ServiceManager = ServiceRequest(session: URLSession.shared),
                             databaseManager: DatabaseManager = Database(),
                             url: URL? = URL(string: "https://jsonblob.com/api/1151549092634943488")) -> ListViewController {
        let view = ListViewController()
        let interactor = ListInteractor(serviceManager: serviceManager,
                                        databaseManager: databaseManager,
                                        url: url)
        let router = ListRouter()
        let presenter = ListPresenter(view: view,
                                      interactor: interactor,
                                      router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        router.view = view
        return view
    }

}

// MARK: - ListRouterProtocol
extension ListRouter: ListRouterProtocol {

}
