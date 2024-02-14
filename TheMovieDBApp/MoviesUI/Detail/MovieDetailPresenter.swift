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
    
    var moviesManager: MoviesManagerProtocol
    var movie: MovieEntity
    var similarMovies: [MovieEntity] = []
    
    // MARK: - Constructors
    

    init(movie: MovieEntity, moviesManager: MoviesManagerProtocol) {
        self.moviesManager = moviesManager
        self.movie = movie
    }
    
    // MARK: - Methods

    /**
     Fetches detailed movie information from the remote data source and updates the `movie` property.
     
     This function makes an asynchronous network request to retrieve detailed movie information for the movie represented by the `movie` property. Upon a successful request, the `movie` property is updated with the new data.
     
     - Note: If an error occurs during the network request, it should be logged appropriately.
     
     # See Also:
     - `MovieModel`: The data model representing movie details.
     - `TheMovieDbAPIEndpoint`: An endpoint for making API requests to The Movie Database (TMDb).
     - `NetworkManager`: A manager for handling network requests.
     */
    func getMovieDetail() async {
        do {
            if let remoteMovie = try await moviesManager.getMovieDetail(id: movie.id) {
                movie = remoteMovie
            }
        } catch {
            Logger.error("Error on Getting Movie details \(error.localizedDescription)")
        }
    }
    
    /**
     Fetches similar movies from the remote data source and updates the `similarMovies` array.
     
     This function makes an asynchronous network request to retrieve a list of similar movies for the movie represented by the `movie` property. Upon a successful request, the `similarMovies` array is updated with the new data.
     
     Additionally, it ensures that the remote data is synchronized with the local database using the `MoviesRepository`.
     
     - Note: If an error occurs during the network request, it should be logged appropriately.
     
     # See Also:
     - `MovieModel`: The data model representing movie details.
     - `MoviesRepository`: A repository for managing movie data in the app.
     - `TheMovieDbAPIEndpoint`: An endpoint for making API requests to The Movie Database (TMDb).
     - `NetworkManager`: A manager for handling network requests.
     */
    func getSimilarMovies() async {
        do {
            let remoteMovies = try await moviesManager.getSimilarMovies(to: movie.id)

            similarMovies = remoteMovies
        } catch {
            Logger.error("Error on Getting Similar movies \(error.localizedDescription)")
        }
    }
}
