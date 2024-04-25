//
//  MoviesListPresenter.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation
import SwiftUI
import TmdbCore

@Observable
class MoviesListPresenter {
    
    // MARK: - Properties
    
    var moviesService: MoviesServiceProtocol
    var currentPage = 1
    var isLoading = false
    var isOnError = false
    var isSearchActive = false
    
    // MARK: - Constructors
    
    init(moviesService: MoviesServiceProtocol) {
        self.moviesService = moviesService
    }
    
    // MARK: - Methods
    
    func getMovies(page: Int) async {
        do {
            try await moviesService.fetchTopMovies(page: page)
            isOnError = false
        } catch {
            Logger.error("Error on Getting Movies \(error.localizedDescription)")
            isOnError = true
        }
    }
    
    func fetchMoreMovies() async {
        if currentPage < Constants.maximumInfiniteScrollPages {
            isLoading = true
            
            await getMovies(page: currentPage + 1)
            
            currentPage += 1
            isLoading = false
        }
    }
}
