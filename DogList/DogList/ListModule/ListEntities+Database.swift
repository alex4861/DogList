//
//  ListEntities+Database.swift
//  DogList
//
//  Created by Alejandro Rodriguez on 06/06/25.
//

import RealmSwift

extension DogEntity {

    /// Converts the ``DogEntity`` to a ``Dog`` Realm model.
    func toDatabaseModel() -> Dog {
        let dog = Dog()
        if let id = id {
            dog.id = id
        }
        dog.dogName = dogName
        dog.dogDescription = description
        dog.age = age
        dog.image = image
        return dog
    }

}
