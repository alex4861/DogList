//
//  Database.swift
//  DogList
//
//  Created by Alejandro Rodriguez on 06/06/25.
//

import RealmSwift
import Foundation

actor Database: DatabaseManager {

    private let identifier: String

    init(identifier: String = "Default") {
        self.identifier = identifier
    }

    private func createURL() -> URL {
        let fileName = "realm-\(identifier).realm"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent(fileName)
    }

    func save(entities: [DogEntity]) async throws {
        let config = Realm.Configuration(fileURL: createURL())
        let realm = try await Realm.open(configuration: config)
        let array = entities.map({ $0.toDatabaseModel() })
        try realm.write {
            realm.add(array, update: .all)
        }
    }

    func getSavedEntities() async throws -> [DogEntity] {
        let config = Realm.Configuration(fileURL: createURL())
        let realm = try await Realm.open(configuration: config)
        let objects = realm.objects(Dog.self)
        return objects.map({ $0.toEntities() })
    }

}
