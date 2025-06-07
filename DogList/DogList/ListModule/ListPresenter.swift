//
//  ListPresenter.swift
//  DogList
//
//  Created Alejandro Rodriguez on 06/06/25.
//  Copyright © 2025. All rights reserved.
//
//

import UIKit

final class ListPresenter: NSObject {

    // MARK: - Variables

    weak var view: ListViewProtocol?
    var interactor: ListInteractorInputProtocol?
    var router: ListRouterProtocol?
    var items: [DogEntity] = []

    @discardableResult
    func loadImage(from url: URL, cell: ListCell, indexPath: IndexPath) -> Task<Void, Never> {
        Task {
            do {
                let image = try await interactor?.loadImage(from: url)
                await MainActor.run {
                    view?.configureImage(image, cell: cell, indexPath: indexPath)
                }
            } catch {
                await MainActor.run {
                    view?.configureErrorImage(cell: cell, indexPath: indexPath)
                }
            }
        }
    }

    // MARK: - Initializer

    init(view: ListViewProtocol? = nil,
         interactor: ListInteractorInputProtocol? = nil,
         router: ListRouterProtocol? = nil) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

}
extension ListPresenter: ListPresenterProtocol {

    func numberOfRows() -> Int {
        return items.count
    }

    @discardableResult
    func getDogList() -> Task<Void, Never> {
        Task {
            do {
                try await interactor?.getDogList()
            } catch {
                fillData(items: [])
            }
        }
    }

    func getCellData(for indexPath: IndexPath) -> DogEntity? {
        items[safe: indexPath.row]
    }

}

// MARK: - ListInteractorOutputProtocol
extension ListPresenter: ListInteractorOutputProtocol {

    func fillData(items: [DogEntity]) {
        self.items = items
        view?.reloadTableView()
    }

}
