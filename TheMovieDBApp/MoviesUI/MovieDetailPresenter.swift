//
//  MovieDetailPresenter.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation
import SwiftUI
import SwiftData

/**
 A presenter responsible for managing detailed movie information and similar movies.
 
 The `MovieDetailPresenter` class is responsible for coordinating the retrieval of detailed movie information and similar movies associated with a specific movie. It interacts with the data layer and serves as an intermediary for updating the UI with relevant movie details.
 
 # Parameters:
 - `movie`: The `MovieModel` object representing the movie for which details and similar movies are managed.
 - `modelContext`: The `ModelContext` object for managing data in the app.
 
 # Properties:
 - `movie`: The movie for which details and similar movies are managed.
 - `similarMovies`: An array of `MovieModel` objects representing similar movies.
 
 # Functionality:
 The `MovieDetailPresenter` provides the following functionality:
 - Retrieving detailed movie information and updating the `movie` property.
 - Fetching similar movies and updating the `similarMovies` array.
 - Synchronizing data with the `MoviesRepository` to ensure consistency with the local database.
 
 # See Also:
 - `MovieModel`: The data model representing movie details.
 - `MoviesRepository`: A repository for managing movie data in the app.
 - `TheMovieDbAPIEndpoint`: An endpoint for making API requests to The Movie Database (TMDb).
 - `NetworkManager`: A manager for handling network requests.
 
 For more information on using the `MovieDetailPresenter`, refer to the relevant parts of the application's code or user interface.
 
 */
@Observable
class MovieDetailPresenter {
    
    // MARK: - Properties
    
    var modelContext: ModelContext
    var moviesRepository: MoviesRepository
    var movie: MovieModel
    var similarMovies: [MovieModel] = []
    
    // MARK: - Constructors
    
    /**
     Initializes a `MovieDetailPresenter` with the provided `MovieModel` and `ModelContext`.
     
     - Parameters:
     - movie: The `MovieModel` object representing the movie for which details and similar movies are managed.
     - modelContext: The `ModelContext` object for managing data in the app.
     */
    init(movie: MovieModel, modelContext: ModelContext) {
        self.modelContext = modelContext
        self.moviesRepository = MoviesRepository(context: modelContext)
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
            let remoteMovie = try await NetworkManager.shared.fetchData(TheMovieDbAPIEndpoint.movieDetail(id: movie.id), type: MovieDetail.self)
                .toDetailData()
            
            movie = remoteMovie
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
            let remoteMovies = try await NetworkManager.shared.fetchData(TheMovieDbAPIEndpoint.similarMovies(id: movie.id), type: MoviesList.self)
                .toData()
            
            await moviesRepository.sync(remoteMovies)
            
            similarMovies = remoteMovies
        } catch {
            Logger.error("Error on Getting Similar movies \(error.localizedDescription)")
        }
    }
}
