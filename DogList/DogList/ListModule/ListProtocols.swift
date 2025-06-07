//
//  ListProtocols.swift
//  DogList
//
//  Created Alejandro Rodriguez on 06/06/25.
//  Copyright © 2025. All rights reserved.
//
//

import Foundation
import UIKit

// MARK: View -
/// This protocol defines the methods that the View should implement to communicate with the Presenter.
protocol ListViewProtocol: AnyObject {

    var presenter: ListPresenterProtocol? { get set }
    /// Reloads the table view data and stops the loading state.
    func reloadTableView()
    /// Configures the image for the cell with the provided `UIImage`.
    func configureImage(_ image: UIImage?, cell: ListCell, indexPath: IndexPath)
    /// Configures the cell with an error image when the image loading fails.
    func configureErrorImage(cell: ListCell, indexPath: IndexPath)
}

// MARK: Interactor -
/// This protocol defines the methods that the Interactor should implement to communicate with the Presenter.
protocol ListInteractorInputProtocol: AnyObject {

    var presenter: ListInteractorOutputProtocol? { get set }
    /// Retrieves the list of ``DogEntity`` items from the service or cache.
    func getDogList() async throws
    /// Retrives the image from the specified URL and returns it as a `UIImage`.
    func loadImage(from url: URL) async throws -> UIImage
}

/// This protocol defines the methods that the Interactor should implement to communicate with the View.
protocol ListInteractorOutputProtocol: AnyObject {

    /// Fills the view with the provided list of ``DogEntity`` items.
    func fillData(items: [DogEntity])

}

// MARK: Presenter -
/// This protocol defines the methods that the Presenter should implement to communicate
/// with the View, Interactor, and Router.
protocol ListPresenterProtocol: AnyObject {

    var view: ListViewProtocol? { get set }
    var interactor: ListInteractorInputProtocol? { get set }
    var router: ListRouterProtocol? { get set }
    /// Returns the number of rows in the table view.
    func numberOfRows() -> Int
    /// Returns the ``DogEntity`` for the specified index path.
    func getCellData(for indexPath: IndexPath) -> DogEntity?
    /// Initiates the process to get the list of dogs.
    @discardableResult
    func getDogList() -> Task<Void, Never>
    /// Loads the image from the specified `URL` and configures the cell with it.
    @discardableResult
    func loadImage(from url: URL, cell: ListCell, indexPath: IndexPath) -> Task<Void, Never>

}

// MARK: Router -
/// This protocol defines the methods that the Router should implement to handle navigation and module transitions.
protocol ListRouterProtocol: AnyObject {

}
