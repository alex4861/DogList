//
//  Session.swift
//  DogList
//
//  Created by Alejandro Rodriguez on 06/06/25.
//

import Foundation

protocol Session {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)

}

extension URLSession: Session { }
