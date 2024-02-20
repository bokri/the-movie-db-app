//
//  MoviesManagerProtocol.swift
//  
//
//  Created by Aymen Bokri on 14/02/2024.
//

import Foundation

public protocol MoviesServiceProtocol {
    func fetchTopMovies(page: Int) async throws
    func getMovieDetail(id: Int) async throws -> MovieEntity?
    func getSimilarMovies(to id: Int) async throws -> [MovieEntity]
    func searchMovies(text: String) async throws -> [MovieEntity]
}
