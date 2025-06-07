//
//  ListInteractor.swift
//  DogList
//
//  Created Alejandro Rodriguez on 06/06/25.
//  Copyright © 2025. All rights reserved.
//
//

import UIKit

final class ListInteractor: ListInteractorInputProtocol {

    // MARK: - Variables

    var presenter: ListInteractorOutputProtocol?
    var serviceManager: ServiceManager
    var databaseManager: DatabaseManager
    var userDefault: UserDefaults
    var url: URL?
    /// A cache to store images loaded from URLs.
    var cache = NSCache<NSURL, UIImage>()

    init(serviceManager: ServiceManager,
         databaseManager: DatabaseManager,
         userDefault: UserDefaults = .standard,
         url: URL?) {
        self.serviceManager = serviceManager
        self.databaseManager = databaseManager
        self.userDefault = userDefault
        self.url = url
    }

    func getDogList() async throws {
        guard !userDefault.bool(forKey: "isNotFirstLogin") else {
            let response = try await retriveDatabaseList()
            await MainActor.run {
                presenter?.fillData(items: response)
            }
            return }
        guard let url else {
            throw DogListError.description("Bad URL".localized)
        }
        let response = try await serviceManager.getData(from: url, responseType: [DogEntity].self)
        try await databaseManager.save(entities: response)
        userDefault.set(true, forKey: "isNotFirstLogin")
        await MainActor.run {
            presenter?.fillData(items: response)
        }
    }

    /// Retrieves the list of saved ``DogEntity`` items from the database.
    private func retriveDatabaseList() async throws -> [DogEntity] {
        return try await databaseManager.getSavedEntities()
    }

    func loadImage(from url: URL) async throws -> UIImage {
        if let cached = cache.object(forKey: url as NSURL) {
            return cached
        }
        let data = try await serviceManager.getData(from: url)
        guard let image = UIImage(data: data, maxDimension: 480)
        else { throw DogListError.description("Image not found") }
        cache.setObject(image, forKey: url as NSURL)
        return image
    }

}
