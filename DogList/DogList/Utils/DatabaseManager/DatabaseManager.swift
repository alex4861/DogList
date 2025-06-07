//
//  DatabaseManager.swift
//  DogList
//
//  Created by Alejandro Rodriguez on 06/06/25.
//
import Foundation

/// A protocol that defines methods for saving and retrieving ``DogEntity`` objects from a database.
protocol DatabaseManager: AnyObject {

    /// Saves an array of ``DogEntity`` objects to the database.
    func save(entities: [DogEntity]) async throws
    /// Retrieves an array of ``DogEntity`` objects from the database.
    func getSavedEntities() async throws -> [DogEntity]

}
