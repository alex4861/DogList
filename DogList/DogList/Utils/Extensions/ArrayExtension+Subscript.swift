//
//  Array.swift
//  DogList
//
//  Created by Alejandro Rodriguez on 06/06/25.
//

extension Array {

    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }

}
