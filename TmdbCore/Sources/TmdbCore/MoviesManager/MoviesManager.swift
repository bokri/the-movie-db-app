//
//  MoviesManager.swift
//
//
//  Created by Aymen Bokri on 14/02/2024.
//

import Foundation

public class MoviesManager: MoviesManagerProtocol {

    var networkManager: NetworkManagerProtocol!
    var storageManager: MoviesRepositoryProtocol!
    
    init(networkManager: any NetworkManagerProtocol, storageManager: any MoviesRepositoryProtocol) {
        self.networkManager = networkManager
        self.storageManager = storageManager
    }
    
    public init() {
        self.networkManager = NetworkManager.shared
        self.storageManager = MoviesRepository()
    }

    public func fetchTopMovies(page: Int) async throws {
        let endpoint = TheMovieDbAPIEndpoint.topMovies(page: page)
        
        let movies = try await networkManager.fetchData(endpoint, type: MoviesList.self)
        
        try await storageManager.addAndUpdateMedias(movies.results)
    }
    
    public func getMovieDetail(id: Int) async throws -> MovieEntity? {
        let endpoint = TheMovieDbAPIEndpoint.movieDetail(id: id)
        
        let movie = try await networkManager.fetchData(endpoint, type: MovieDetail.self)
        
        try await storageManager.addAndUpdateMedia(movie)
        
        return try await storageManager.getMedia(id: movie.id)
    }
    
    public func getSimilarMovies(to id: Int) async throws -> [MovieEntity] {
        let endpoint = TheMovieDbAPIEndpoint.similarMovies(id: id)
        
        let movies = try await networkManager.fetchData(endpoint, type: MoviesList.self)
        
        try await storageManager.addAndUpdateMedias(movies.results)
        
        return movies.toData().toEntities()
    }
    
    public func searchMovies(text: String) async throws -> [MovieEntity] {
        let endpoint = TheMovieDbAPIEndpoint.searchMovies(text: text)
        
        let movies = try await networkManager.fetchData(endpoint, type: MoviesList.self)
        
        try await storageManager.addAndUpdateMedias(movies.results)
        
        return movies.toData().toEntities()
    }
}

