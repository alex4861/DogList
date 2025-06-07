//
//  DogListUIApp.swift
//  DogListUI
//
//  Created by Alejandro Rodriguez on 06/06/25.
//

import SwiftUI

@main
struct DogListUIApp: App {
    var body: some Scene {
        WindowGroup {
            ListView()
                .environment(
                    ViewModel(serviceManager: ServiceRequest(session: URLSession.shared),
                              databaseManager: Database(),
                              userDefaults: UserDefaults.standard,
                              url: URL(string: "https://jsonblob.com/api/1151549092634943488"))
                )
        }
    }
}
