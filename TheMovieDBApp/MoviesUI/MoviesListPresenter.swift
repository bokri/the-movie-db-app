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
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.moviesRepository = MoviesRepository(context: modelContext)
    }
    
    func getMovies(page: Int) async {
        do {
            let remoteMovies = try await NetworkManager.shared.fetchData(TheMovieDbAPIEndpoint.topMovies(page: page), type: MoviesList.self)
                .toData()

            await moviesRepository.sync(remoteMovies)
        } catch {
            // Log error
        }
    }
}
