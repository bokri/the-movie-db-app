//
//  MovieDetailView.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import SwiftUI
import SwiftData

struct MovieDetailView: View {
    
    private var movie: MovieModel
    @Environment(\.modelContext) var modelContext
    @State private var presenter: MovieDetailPresenter
        
    init(movieModel: MovieModel, modelContext: ModelContext) {
        self.movie = movieModel
        self.presenter = MovieDetailPresenter(modelContext: modelContext, movieId: movieModel.id)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Movie Poster
                PosterImageView(imageURL: Constants.imagesBaseUrl + movie.posterPath, width: nil, height: 400)
                        .cornerRadius(10)

                // Movie Title
                Text(movie.title)
                    .font(.title)
                    .fontWeight(.bold)

                // Movie Overview
                Text(movie.overview)
                    .font(.body)
                    .multilineTextAlignment(.leading)

                // Release Date
                Text("Release Date: \(movie.releaseDate.formatDateString() ?? "")")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                // Genres
                Text("Genres: \(movie.genres.map { $0.name }.joined(separator: ", ") ?? "")")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                // Vote Average
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text(String(format: "%.1f", movie.voteAverage ?? 0.0))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                // Original Language
                if let originalLanguage = movie.originalLanguage {
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
                                NavigationLink(destination: MovieDetailView(movieModel: similarMovie, modelContext: modelContext).environment(\.modelContext, modelContext)) {
                                    SimilarMovieCard(similarMovie: similarMovie)
                                }
                            }
                        }
                        .padding(16)
                    }
                }

                Spacer()
            }
            .padding(16)
        }
        .navigationBarTitle("Movie Details")
    }
}
