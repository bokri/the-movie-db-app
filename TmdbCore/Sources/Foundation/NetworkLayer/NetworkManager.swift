//
//  NetworkManager.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation

/**
 A manager for performing network operations and handling data retrieval from API endpoints.
 
 The `NetworkManager` class provides a central point for managing network requests and data retrieval operations. It supports asynchronous fetching of data from various API endpoints using different HTTP methods and provides a mechanism for handling network errors and decoding retrieved data into Swift model types.
 
 - Note: This class is typically used to make network requests, process responses, and decode data from remote APIs. It can handle GET, POST, and PUT requests and provides error handling for network-related issues.
 */
public class NetworkManager {
    /// The shared instance of the `NetworkManager class.
    public static let shared = NetworkManager()
    
    private init() {}
    
    /**
     Creates a URL request for the specified API endpoint.
     - Parameters:
     - endpoint: An object conforming to the APIEndpoint protocol that specifies the details of the request.
     
     - Returns: A URLRequest instance representing the network request, or nil if there's an issue with the URL construction.
     */
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
    
    /**
     Fetches data from the specified API endpoint and decodes it into a Swift model.
     - Parameters:
        - endpoint: An object conforming to the APIEndpoint protocol that specifies the details of the request.
        - type: The type of the Swift model to decode the retrieved data into.
     
     - Returns: A Swift model instance containing the decoded data.
     
     - Throws: An error of type NetworkError if any network-related issue occurs, or other decoding errors.
     */
    public func fetchData<T: Decodable>(_ endpoint: APIEndpoint, type: T.Type) async throws -> T {
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
