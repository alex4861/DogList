//
//  ListTableViewCell.swift
//  DogList
//
//  Created by Alejandro Rodriguez on 06/06/25.
//

import UIKit

class ListTableViewCell: UITableViewCell, ListCell {

    @IBOutlet weak var imgCell: UIImageView!
    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var txtDescription: UILabel!
    @IBOutlet weak var txtAge: UILabel!
    @IBOutlet weak var viewContainer: UIView!

    var indexPath: IndexPath?

    override func awakeFromNib() {
        super.awakeFromNib()
        imgCell.layer.cornerRadius = 16
        viewContainer.layer.cornerRadius = 16
    }

    func configure(with data: DogEntity, indexPath: IndexPath?) {
        self.indexPath = indexPath
        txtName.text = data.dogName
        txtDescription.text = data.description
        txtAge.text = "Dog.Age".localized(with: data.age)
        imgCell.accessibilityIdentifier = data.dogName
    }

    func configureImage(_ image: UIImage?, indexPath: IndexPath?) {
        if indexPath == self.indexPath {
            imgCell.image = image
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        txtName.text = ""
        txtDescription.text = ""
        txtAge.text = ""
        imgCell.image = nil
    }

}
