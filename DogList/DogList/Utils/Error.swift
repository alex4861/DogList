//
//  Error.swift
//  DogList
//
//  Created by Alejandro Rodriguez on 06/06/25.
//

import Foundation

enum DogListError: Error, Equatable {
    case description(_ value: String)
}
