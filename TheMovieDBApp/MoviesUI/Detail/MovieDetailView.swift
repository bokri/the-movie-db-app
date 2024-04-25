//
//  MovieDetailView.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import SwiftUI
import TmdbCore

struct MovieDetailView: View {
    
    // MARK: - Properties
    
    @State private var presenter: MovieDetailPresenter
    
    // MARK: - Constructors
    
    init(movie: MovieEntity, moviesService: MoviesServiceProtocol) {
        self.presenter = MovieDetailPresenter(movie: movie, moviesService: moviesService)
    }
    
    // MARK: - SwiftUI
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Movie Poster
                PosterImageView(imageURL: Constants.imagesBaseUrl + presenter.movie.posterPath,
                                width: UIScreen.main.bounds.width,
                                height: 400)
                .cornerRadius(10)
                
                // Movie Title
                Text(presenter.movie.title)
                    .font(.title)
                    .fontWeight(.bold)
                
                // Movie Overview
                Text(presenter.movie.overview)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                
                // Release Date
                Text("Release Date: \(presenter.movie.releaseDate.formatDateString())")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                // Genres
                Text("Genres: \(presenter.movie.genres.joined(separator: ", "))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                // Vote Average
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text(String(format: "%.1f", presenter.movie.voteAverage ?? 0.0))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                // Original Language
                if let originalLanguage = presenter.movie.originalLanguage {
                    Text("Original Language: \(originalLanguage)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                // Similar Movies
                if !presenter.similarMovies.isEmpty {
                    Text("Similar Movies")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 16)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(presenter.similarMovies) { similarMovie in
                                SimilarMovieCard(similarMovie: similarMovie)
                            }
                        }
                        .padding(16)
                    }
                }
                
                Spacer()
            }
            .padding(16)
        }
        .navigationBarTitle(presenter.movie.title)
        .task {
            await presenter.getMovieDetail()
            await presenter.getSimilarMovies()
        }
    }
}
