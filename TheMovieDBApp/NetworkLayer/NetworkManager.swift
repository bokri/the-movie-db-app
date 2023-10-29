//
//  NetworkManager.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    private func makeURLRequest(for endpoint: APIEndpoint) -> URLRequest? {
        guard var urlComponents = URLComponents(string: endpoint.url) else {
            return nil
        }
        
        // Add query items to the URL for GET requests
        if endpoint.method == .get {
            urlComponents.queryItems = endpoint.parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        }
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue
        
        // Set request headers
        if let headers = endpoint.headers {
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        // Set request body for POST and PUT requests
        if let requestBody = endpoint.requestBody {
            urlRequest.httpBody = requestBody
        }
        
        return urlRequest
    }
    
    func fetchData<T: Decodable>(_ endpoint: APIEndpoint, type: T.Type) async throws -> T {
        guard let urlRequest = makeURLRequest(for: endpoint) else {
            throw NetworkError.badURL
            
        }
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw error
        }
    }
}
