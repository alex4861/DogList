//
//  Dog+DTO.swift
//  DogListUI
//
//  Created by Alejandro Rodriguez on 06/06/25.
//

extension Dog {

    /// Converts the ``Dog`` to a ``DogEntity``.
    func toEntities() -> DogEntity {
        DogEntity(id: id, dogName: dogName, description: dogDescription, age: age, image: image)
    }

}
