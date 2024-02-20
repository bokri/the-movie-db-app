//
//  MoviesManager.swift
//
//
//  Created by Aymen Bokri on 14/02/2024.
//

import Foundation

public class MoviesService: MoviesServiceProtocol {

    var networkService: NetworkServiceProtocol!
    var storageRepository: MoviesRepositoryProtocol!
    
    init(networkService: any NetworkServiceProtocol, storageManager: any MoviesRepositoryProtocol) {
        self.networkService = networkService
        self.storageRepository = storageManager
    }
    
    public init() {
        self.networkService = NetworkService.shared
        self.storageRepository = MoviesRepository()
    }

    public func fetchTopMovies(page: Int) async throws {
        let endpoint = TheMovieDbAPIEndpoint.topMovies(page: page)
        
        let movies = try await networkService.fetchData(endpoint, type: MoviesList.self)
        
        try await storageRepository.addAndUpdateMedias(movies.results)
    }
    
    public func getMovieDetail(id: Int) async throws -> MovieEntity? {
        let endpoint = TheMovieDbAPIEndpoint.movieDetail(id: id)
        
        let movie = try await networkService.fetchData(endpoint, type: MovieDetail.self)
        
        try await storageRepository.addAndUpdateMedia(movie)
        
        return try await storageRepository.getMedia(id: movie.id)
    }
    
    public func getSimilarMovies(to id: Int) async throws -> [MovieEntity] {
        let endpoint = TheMovieDbAPIEndpoint.similarMovies(id: id)
        
        let movies = try await networkService.fetchData(endpoint, type: MoviesList.self)
        
        try await storageRepository.addAndUpdateMedias(movies.results)
        
        return movies.toData().toEntities()
    }
    
    public func searchMovies(text: String) async throws -> [MovieEntity] {
        let endpoint = TheMovieDbAPIEndpoint.searchMovies(text: text)
        
        let movies = try await networkService.fetchData(endpoint, type: MoviesList.self)
        
        try await storageRepository.addAndUpdateMedias(movies.results)
        
        return movies.toData().toEntities()
    }
}

