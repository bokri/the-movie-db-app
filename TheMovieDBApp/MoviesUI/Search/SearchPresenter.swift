//
//  SearchPresenter.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 15/02/2024.
//

import Foundation
import SwiftUI
import TmdbCore

@Observable
class SearchPresenter {
    
    // MARK: - Properties
    
    var moviesService: MoviesServiceProtocol
    var searchText: String = ""
    var searchIsActive: Bool = false
    var searchMovies: [MovieEntity] = []
    
    // MARK: - Constructors
    
    init(moviesService: MoviesServiceProtocol) {
        self.moviesService = moviesService
    }
    
    // MARK: - Methods
    
    func emptySearchMovies() {
        searchMovies = []
    }
    
    func searchMovies() async {
        do {
            searchMovies = try await moviesService.searchMovies(text: searchText)
        } catch {
            searchMovies = []
            Logger.error("Error on Getting Movies \(error.localizedDescription)")
        }
    }
}
