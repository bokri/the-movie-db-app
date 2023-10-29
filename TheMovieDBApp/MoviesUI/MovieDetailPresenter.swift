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
    var movie: MovieModel
    var similarMovies: [MovieModel] = []
    
    init(movie: MovieModel, modelContext: ModelContext) {
        self.modelContext = modelContext
        self.moviesRepository = MoviesRepository(context: modelContext)
        self.movie = movie
    }
    
    func getMovieDetail() async {
        do {
            let remoteMovie = try await NetworkManager.shared.fetchData(TheMovieDbAPIEndpoint.movieDetail(id: movie.id), type: MovieDetail.self)
                .toDetailData()
                        
            movie = remoteMovie
        } catch {
            // Log error
        }
    }
    
    func getSimilarMovies() async {
        do {
            let remoteMovies = try await NetworkManager.shared.fetchData(TheMovieDbAPIEndpoint.similarMovies(id: movie.id), type: MoviesList.self)
                .toData()

            await moviesRepository.sync(remoteMovies)
            
            similarMovies = remoteMovies
        } catch {
            // Log error
        }
    }
}
