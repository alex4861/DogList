//
//  ServiceManager.swift
//  DogList
//
//  Created by Alejandro Rodriguez on 06/06/25.
//

import Foundation

protocol ServiceManager: AnyObject {

    /// A shared instance of the `ServiceManager` for singleton access.
    var session: Session { get }
    /// A method to fetch data from a given URL and return it as ``Data``.
    func getData(from url: URL) async throws -> Data
    /// A method to fetch data from a given ``URL`` and decode it into a specified type.
    func getData<T: Encodable & Decodable>(from url: URL,
                                           responseType: T.Type) async throws -> T

}
