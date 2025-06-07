//
//  Error.swift
//  DogListUI
//
//  Created by Alejandro Rodriguez on 06/06/25.
//

/// This file defines a custom error type.
import Foundation

enum DogListError: Error, Equatable {
    case description(_ value: String)
}
