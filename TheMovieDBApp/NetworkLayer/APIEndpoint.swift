//
//  APIEndpoint.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation

public protocol APIEndpoint {
    var url: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any] { get }
    var requestBody: Data? { get }
    var headers: [String: String]? { get }
}
