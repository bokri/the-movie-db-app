//
//  SearchPresenter.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 15/02/2024.
//

import Foundation
import SwiftUI
import SwiftData
import TmdbCore

@Observable
class SearchPresenter {
    
    // MARK: - Properties
    
    var moviesManager: MoviesManagerProtocol
    var searchText: String = ""
    var searchIsActive: Bool = false
    var searchMovies: [MovieEntity] = []
    
    // MARK: - Constructors
    
    init(moviesManager: MoviesManagerProtocol) {
        self.moviesManager = moviesManager
    }
    
    // MARK: - Methods
    
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
}
