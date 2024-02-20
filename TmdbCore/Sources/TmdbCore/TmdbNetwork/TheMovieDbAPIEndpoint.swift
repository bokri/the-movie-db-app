//
//  TheMovieDbAPIEndpoint.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation

/**
 **
  An enumeration that represents various API endpoints for The Movie Database (TMDb).

  The `TheMovieDbAPIEndpoint` enumeration defines a set of API endpoints used to access different features and data related to movies and TV shows on TMDb. Each case of this enumeration corresponds to a specific endpoint and provides details such as the URL, HTTP method, parameters, request body, and headers required for making network requests.

  - Note: This enumeration is used to construct and define the details of network requests for fetching movie-related data from TMDb. It includes endpoints for retrieving top movies, movie details, and similar movies.

 */
public enum TheMovieDbAPIEndpoint: APIEndpoint {
    /// The base URL for TMDb API requests.
    private static let baseURL = "https://api.themoviedb.org/3"
    
    /// Represents an endpoint for fetching the top movies.
    case topMovies(page: Int)
    /// Represents an endpoint for fetching movie details.
    case movieDetail(id: Int)
    /// Represents an endpoint for fetching similar movies for a given movie.
    case similarMovies(id: Int)
    
    case searchMovies(text: String)
    
    /// The path specific to each API endpoint.
    private var path: String {
        return switch self {
        case .topMovies:
            "/discover/movie"
        case .movieDetail(let id):
            "/movie/\(id)"
        case .similarMovies(let id):
            "/movie/\(id)/similar"
        case .searchMovies:
            "/search/movie"
        }
    }
    
    /// A dictionary of parameters to be included in the request.
    public var parameters: [String : Any] {
        var parameters: [String: Any] = [:]
        
        switch self {
        case .topMovies(let page):
            parameters["page"] = page
        case .movieDetail:
            break
        case .similarMovies:
            break
        case .searchMovies(let text):
            parameters["query"] = text
        }
        parameters["api_key"] = ProcessInfo.processInfo.environment["API_KEY"]
        return parameters
    }
    
    /// The HTTP method for this endpoint (e.g., GET, POST, PUT, etc.).
    public var method: HTTPMethod {
        return HTTPMethod.get
    }
    
    /// The complete URL for this endpoint, constructed from the base URL and endpoint-specific path.
    public var url: String {
        return TheMovieDbAPIEndpoint.baseURL + self.path
    }
    
    /// The request body (if any) for this endpoint. Returns nil for GET requests.
    public var requestBody: Data? {
        return nil
    }
    
    /// The request headers (if any) for this endpoint. Returns nil for no specific headers.
    public var headers: [String : String]? {
        return nil
    }
}
