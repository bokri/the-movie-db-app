//
//  MovieDetailPresenter.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation
import SwiftUI
import SwiftData
import TmdbCore

@Observable
class MovieDetailPresenter {
    
    // MARK: - Properties
    
    var moviesService: MoviesServiceProtocol
    var movie: MovieEntity
    var similarMovies: [MovieEntity] = []
    
    // MARK: - Constructors
    

    init(movie: MovieEntity, moviesService: MoviesServiceProtocol) {
        self.moviesService = moviesService
        self.movie = movie
    }
    
    // MARK: - Methods

    func getMovieDetail() async {
        do {
            if let remoteMovie = try await moviesService.getMovieDetail(id: movie.id) {
                movie = remoteMovie
            }
        } catch {
            Logger.error("Error on Getting Movie details \(error.localizedDescription)")
        }
    }
    
    func getSimilarMovies() async {
        do {
            let remoteMovies = try await moviesService.getSimilarMovies(to: movie.id)

            similarMovies = remoteMovies
        } catch {
            Logger.error("Error on Getting Similar movies \(error.localizedDescription)")
        }
    }
}
