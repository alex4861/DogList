//
//  ListViewController.swift
//  DogList
//
//  Created Alejandro Rodriguez on 06/06/25.
//  Copyright © 2025. All rights reserved.
//
//

import UIKit

final class ListViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Presenter

	var presenter: ListPresenterProtocol?

    // MARK: - Lifecycle
	override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ListTableViewCell", bundle: .main),
                           forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
        presenter?.getDogList()
        navigationController?.setNavigationBarHidden(false, animated: false)
        setupCustomBackButton()
        navigationItem.titleView = createTitleView()
    }

    /// Sets up a custom back button for the navigation bar with a chevron icon
    func setupCustomBackButton() {
        let button = UIButton(type: .system)
        var configuration = UIButton.Configuration.plain()
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 17, weight: .medium)
        configuration.image = UIImage(systemName: "chevron.backward", withConfiguration: symbolConfig)
        configuration.baseForegroundColor = UIColor(named: "AppSecondaryColor")
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 12, bottom: 0, trailing: -12)
        button.configuration = configuration
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = barButton
    }

    /// Creates a custom title view for the navigation bar wit specific styling
    func createTitleView() -> UIView {
        let view = UIView()
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        label.text = "App.Title".localized
        label.textColor = UIColor(named: "AppPrimaryColor")
        view.addSubview(label)
        view.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        label.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        return view
    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource
/// This extension implements the UITableViewDelegate and UITableViewDataSource protocols to manage
/// the table view's data and interactions.
extension ListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.numberOfRows() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        guard let cell = cell as? ListTableViewCell
        else { return cell }
        if let entity = presenter?.getCellData(for: indexPath) {
            cell.configure(with: entity, indexPath: indexPath)
            guard let url = URL(string: entity.image) else { return cell }
            presenter?.loadImage(from: url, cell: cell, indexPath: indexPath)
        }
        return cell
    }

}

// MARK: - ListViewProtocol
extension ListViewController: ListViewProtocol {

    func configureImage(_ image: UIImage?, cell: ListCell, indexPath: IndexPath) {
        cell.configureImage(image, indexPath: indexPath)
    }

    func reloadTableView() {
        tableView.reloadData()
    }

    func configureErrorImage(cell: ListCell, indexPath: IndexPath) {
        cell.configureImage(UIImage(named: "ErrorImage"), indexPath: indexPath)
    }

}
