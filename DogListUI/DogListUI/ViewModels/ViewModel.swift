//
//  ViewModel.swift
//  DogListUI
//
//  Created by Alejandro Rodriguez on 06/06/25.
//
import SwiftUI

@Observable class ViewModel: ViewModelProtocol {

    var items: [DogEntity] = []
    var url: URL?

    var serviceManager: ServiceManager
    var databaseManager: DatabaseManager
    var userDefaults: UserDefaults

    required init(serviceManager: ServiceManager,
                  databaseManager: DatabaseManager,
                  userDefaults: UserDefaults = .standard,
                  url: URL?) {
        self.serviceManager = serviceManager
        self.databaseManager = databaseManager
        self.userDefaults = userDefaults
        self.url = url
    }

    func fecthDogs() async throws {
        guard let url else {
            throw DogListError.description("Bad URL")
        }
        guard !userDefaults.bool(forKey: "isNotFirstLogin") else {
            items = try await databaseManager.getSavedEntities()
            return
        }
        let response = try await serviceManager.getData(from: url, responseType: [DogEntity].self)
        try await databaseManager.save(entities: response)
        print("fetched from service")
        userDefaults.set(true, forKey: "isNotFirstLogin")
        items = response
    }

}
