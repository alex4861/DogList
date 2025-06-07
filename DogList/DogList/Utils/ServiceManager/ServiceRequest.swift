//
//  ServiceRequest.swift
//  DogList
//
//  Created by Alejandro Rodriguez on 06/06/25.
//

import Foundation

class ServiceRequest: ServiceManager {

    let session: Session

    init(session: Session) {
        self.session = session
    }

    func getData(from url: URL) async throws -> Data {
        var request =  URLRequest(url: url)
        request.httpMethod = "GET"
        let (data, _) = try await session.data(for: request)
        return data
    }

    func getData<T: Encodable & Decodable>(from url: URL,
                                           responseType: T.Type) async throws -> T {
        let data = try await getData(from: url)
        return try JSONDecoder().decode(responseType, from: data)
    }

}
