//
//  ViewModelProtocol.swift
//  DogListUI
//
//  Created by Alejandro Rodriguez on 06/06/25.
//

import Foundation

/// Protocol defining the ViewModel's responsibilities and properties.
protocol ViewModelProtocol: Observable {

    /// The list of dog entities managed by the view model.
    var items: [DogEntity] { get set }
    /// The service manager responsible for network requests.
    var serviceManager: ServiceManager { get set }
    /// The database manager responsible for local data storage.
    var databaseManager: DatabaseManager { get set }
    /// The user defaults manager for storing user preferences.
    var userDefaults: UserDefaults { get set }

    init(serviceManager: ServiceManager,
         databaseManager: DatabaseManager,
         userDefaults: UserDefaults,
         url: URL?)

    /// Fetches dog entities from the service or database.
    func fecthDogs() async throws

}
