//
//  MoviesListPresenter.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation
import SwiftUI
import SwiftData

/**
 A presenter responsible for managing a list of movies and supporting infinite scrolling.
 
 The `MoviesListPresenter` class is responsible for coordinating the retrieval of a list of movies and enabling infinite scrolling to fetch more movies as needed. It interacts with the data layer and serves as an intermediary for updating the UI with movie data.
 
 # Parameters:
 - `modelContext`: The `ModelContext` object for managing data in the app.
 
 # Properties:
 - `currentPage`: The current page number for fetching movies.
 - `isLoading`: A flag indicating whether the presenter is currently fetching data.
 
 # Functionality:
 The `MoviesListPresenter` provides the following functionality:
 - Retrieving a list of movies from a remote data source.
 - Supporting infinite scrolling by fetching additional pages of movies.
 - Synchronizing data with the `MoviesRepository` to ensure consistency with the local database.
 
 # See Also:
 - `MoviesRepository`: A repository for managing movie data in the app.
 - `TheMovieDbAPIEndpoint`: An endpoint for making API requests to The Movie Database (TMDb).
 - `NetworkManager`: A manager for handling network requests.
 - `Logger`: A logging utility for error handling.
 
 For more information on using the `MoviesListPresenter`, refer to the relevant parts of the application's code or user interface.
 
 */
@Observable
class MoviesListPresenter {
    
    // MARK: - Properties
    
    var modelContext: ModelContext
    var moviesRepository: MoviesRepository
    var currentPage = 1
    var isLoading = false
    
    // MARK: - Constructors
    
    /**
     Initializes a `MoviesListPresenter` with the provided `ModelContext`.
     
     - Parameters:
     - modelContext: The `ModelContext` object for managing data in the app.
     */
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.moviesRepository = MoviesRepository(context: modelContext)
    }
    
    // MARK: - Methods
    
    /**
     Fetches a list of movies from the remote data source and synchronizes them with the local database.
     
     This function makes an asynchronous network request to retrieve a list of movies from a specified page. The fetched data is then synchronized with the local database using the `MoviesRepository`.
     
     - Parameters:
     - page: The page number of the movies to retrieve.
     
     - Note: If an error occurs during the network request or data synchronization, it should be logged appropriately.
     
     # See Also:
     - `MoviesRepository`: A repository for managing movie data in the app.
     - `TheMovieDbAPIEndpoint`: An endpoint for making API requests to The Movie Database (TMDb).
     - `NetworkManager`: A manager for handling network requests.
     - `Logger`: A logging utility for error handling.
     */
    func getMovies(page: Int) async {
        do {
            let remoteMovies = try await NetworkManager.shared.fetchData(TheMovieDbAPIEndpoint.topMovies(page: page), type: MoviesList.self).toData()
            
            await moviesRepository.sync(remoteMovies)
        } catch {
            Logger.error("Error on Getting Movies \(error.localizedDescription)")
        }
    }
    
    /**
     Fetches more movies by increasing the current page and enabling infinite scrolling.
     
     This function increases the current page number and sets the `isLoading` flag to `true` to indicate that more movies are being fetched. It then fetches movies from the updated page and, upon successful retrieval, updates the current page and resets the `isLoading` flag.
     
     - Note: The function includes logic to prevent fetching more data beyond a specified maximum page count.
     
     # See Also:
     - `TheMovieDbAPIEndpoint`: An endpoint for making API requests to The Movie Database (TMDb).
     - `NetworkManager`: A manager for handling network requests.
     */
    func fetchMoreMovies() async {
        if currentPage < Constants.maximumInfiniteScrollPages {
            isLoading = true
            
            await getMovies(page: currentPage + 1)
            
            currentPage += 1
            isLoading = false
        }
    }
}
