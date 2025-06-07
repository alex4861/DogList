//
//  String+Localizable.swift
//  DogList
//
//  Created by Alejandro Rodriguez on 06/06/25.
//

import Foundation

extension String {

    var localized: String {
        NSLocalizedString(self, comment: "Localized text from: \(self)")
    }

    func localized(with arguments: CVarArg...) -> String {
        String(format: NSLocalizedString(self, comment: ""), arguments: arguments)
    }

}
