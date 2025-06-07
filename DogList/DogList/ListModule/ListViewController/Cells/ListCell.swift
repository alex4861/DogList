//
//  ListCell.swift
//  DogList
//
//  Created by Alejandro Rodriguez on 06/06/25.
//

import UIKit

protocol ListCell: AnyObject {
    var indexPath: IndexPath? { get set }
    /// Configures the cell with the provided image.
    func configureImage(_ image: UIImage?, indexPath: IndexPath?)
    /// Configures the cell with the provided dog data.
    func configure(with data: DogEntity, indexPath: IndexPath?)
}
