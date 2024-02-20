//
//  NetworkManagerProtocol.swift
//
//
//  Created by Aymen Bokri on 30/10/2023.
//

import Foundation

public protocol NetworkServiceProtocol {
    func fetchData<T: Decodable>(_ endpoint: APIEndpoint, type: T.Type) async throws -> T
}
