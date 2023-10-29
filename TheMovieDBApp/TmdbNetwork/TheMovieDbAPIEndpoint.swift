//
//  TheMovieDbAPIEndpoint.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation

public enum TheMovieDbAPIEndpoint: APIEndpoint {
    private static let baseURL = "https://api.themoviedb.org/3"
    
    case topMovies(page: Int)
    case movieDetail(id: Int)
    case similarMovies(id: Int)
    
    private var path: String {
        return switch self {
        case .topMovies:
            "/discover/movie"
        case .movieDetail(let id):
            "/movie/\(id)"
        case .similarMovies(let id):
            "/movie/\(id)/similar"
        }
    }
    
    public var parameters: [String : Any] {
        var parameters: [String: Any] = [:]
        
        switch self {
        case .topMovies(let page):
            parameters["page"] = page
        case .movieDetail:
            break
        case .similarMovies:
            break
        }
        parameters["api_key"] = ProcessInfo.processInfo.environment["API_KEY"]
        return parameters
    }
    
    public var method: HTTPMethod {
        return HTTPMethod.get
    }
    
    public var url: String {
        return TheMovieDbAPIEndpoint.baseURL + self.path
    }
    
    public var requestBody: Data? {
        return nil
    }
    
    public var headers: [String : String]? {
        return nil
    }
}
