//
//  DogEntity.swift
//  DogListUI
//
//  Created by Alejandro Rodriguez on 06/06/25.
//

import Foundation

// MARK: - DogEntity
// This struct represents a Dog entity that conforms to Codable for easy JSON encoding/decoding.
struct DogEntity: Codable, Identifiable {
    /// A unique identifier for the dog.
    var id: String = UUID().uuidString
    /// The name of the dog.
    var dogName: String
    /// A description of the dog.
    var description: String
    /// The age of the dog in years.
    var age: Int
    /// The URL of the dog's image.
    var image: String

    enum CodingKeys: String, CodingKey {
        case dogName, description, age, image
    }

}
