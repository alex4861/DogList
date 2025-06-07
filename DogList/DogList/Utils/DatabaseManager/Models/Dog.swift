//
//  Dog.swift
//  DogList
//
//  Created by Alejandro Rodriguez on 06/06/25.
//

import Foundation
import RealmSwift

/// Represents a dog object in the Realm database.
final class Dog: Object {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var dogName: String
    @Persisted var dogDescription: String
    @Persisted var age: Int
    @Persisted var image: String
}
