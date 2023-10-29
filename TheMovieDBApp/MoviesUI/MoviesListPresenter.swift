//
//  MoviesListPresenter.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation
import SwiftUI
import SwiftData

@Observable
class MoviesListPresenter {

    var modelContext: ModelContext
    var moviesRepository: MoviesRepository
    var currentPage = 1
    var isLoading = false
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.moviesRepository = MoviesRepository(context: modelContext)
    }
    
    func getMovies(page: Int) async {
        do {
            let remoteMovies = try await NetworkManager.shared.fetchData(TheMovieDbAPIEndpoint.topMovies(page: page), type: MoviesList.self).toData()
            
            await moviesRepository.sync(remoteMovies)
        } catch {
            Logger.error("Error on Getting Movies \(error.localizedDescription)")
        }
    }
    
    func fetchMoreMovies() async {
        if currentPage < 500 {
            isLoading = true

            await getMovies(page: currentPage + 1)

            currentPage += 1
            isLoading = false
        }
    }
}
