//
//  MoviesListPresenter.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation
import SwiftUI
import SwiftData
import TmdbCore


@Observable
class MoviesListPresenter {
    
    // MARK: - Properties
    
    var moviesManager: MoviesManagerProtocol
    var currentPage = 1
    var isLoading = false
    var isOnError = false
    
    var searchText: String = ""
    var searchIsActive: Bool = false
    var searchMovies: [MovieEntity] = []
    
    // MARK: - Constructors
    
    init(moviesManager: MoviesManagerProtocol) {
        self.moviesManager = moviesManager
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
            try await moviesManager.fetchTopMovies(page: page)
            isOnError = false
        } catch {
            Logger.error("Error on Getting Movies \(error.localizedDescription)")
            isOnError = true
        }
    }
    
    func emptySearchMovies() {
        searchMovies = []
    }
    
    func searchMovies() async {
        do {
            searchMovies = try await moviesManager.searchMovies(text: searchText)
        } catch {
            searchMovies = []
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
