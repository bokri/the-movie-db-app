//
//  MovieDetailPresenter.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation
import SwiftUI
import SwiftData

@Observable
class MovieDetailPresenter {

    var modelContext: ModelContext
    var moviesRepository: MoviesRepository
    var movieId: Int
    var similarMovies: [MovieModel] = []
    
    init(modelContext: ModelContext, movieId: Int) {
        self.modelContext = modelContext
        self.moviesRepository = MoviesRepository(context: modelContext)
        self.movieId = movieId
    }
    
    func getSimilarMovies() async {
        do {
            let remoteMovies = try await NetworkManager.shared.fetchData(TheMovieDbAPIEndpoint.similarMovies(id: movieId), type: MoviesList.self)
                .toData()

            await moviesRepository.sync(remoteMovies)
            
            similarMovies = remoteMovies
        } catch {
            // Log error
        }
    }
}
