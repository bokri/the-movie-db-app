//
//  MovieDetailView.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import SwiftUI
import SwiftData
import TmdbCore

/**
 A SwiftUI view for displaying detailed information about a movie.
 
 The `MovieDetailView` struct is a SwiftUI view designed to display comprehensive information about a movie. It includes details such as the movie poster, title, overview, release date, genres, vote average, original language, and a list of similar movies.
 
 # Parameters:
 - `movieModel`: The `MovieModel` object representing the movie for which details are to be displayed.
 - `modelContext`: The `ModelContext` object for managing data in the app.
 
 # Subviews:
 The `MovieDetailView` view contains the following subviews:
 - `PosterImageView`: For displaying the movie's poster image.
 - `Text`: For displaying the movie's title, overview, release date, genres, and other information.
 - `HStack`: For displaying the star icon and vote average.
 - `ScrollView`: For enabling scrolling of the content.
 - `SimilarMovieCard`: A custom view for displaying similar movies in a horizontal list layout.
 
 # Functionality:
 The `MovieDetailView` provides the following functionality:
 - Displaying detailed information about a movie, including poster, title, overview, release date, genres, and more.
 - Loading similar movies in a horizontal list layout if available.
 - Automatically fetching detailed movie information and similar movies on view presentation.
 
 # See Also:
 - `MovieModel`: The data model representing movie details.
 - `PosterImageView`: A view for displaying movie posters with optional caching.
 - `SimilarMovieCard`: A custom view for displaying information about similar movies.
 - `MovieDetailPresenter`: The presenter responsible for managing detailed movie information.
 
 For more information on using the `MovieDetailView` and its subviews, refer to the relevant parts of the application's code or user interface.
 
 */
struct MovieDetailView: View {
    
    // MARK: - Properties
    
    @Environment(\.modelContext) var modelContext
    @State private var presenter: MovieDetailPresenter
    
    // MARK: - Constructors
    
    /**
     Initializes a `MovieDetailView` with the provided `MovieModel` and `ModelContext`.
     
     - Parameters:
     - movieModel: The `MovieModel` object representing the movie for which details are to be displayed.
     - modelContext: The `ModelContext` object for managing data in the app.
     */
    init(movieModel: MovieModel, modelContext: ModelContext) {
        self.presenter = MovieDetailPresenter(movie: movieModel, modelContext: modelContext)
    }
    
    // MARK: - SwiftUI
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Movie Poster
                PosterImageView(imageURL: Constants.imagesBaseUrl + presenter.movie.posterPath, width: nil, height: 400)
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

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: MovieModel.self, configurations: config)
    let modelContext = ModelContext(container)
    
    let movieModel = MovieModel(id: 1,
                                title: "Titanic",
                                overview: "Titanic is a good movie !",
                                releaseDate: "2001-01-01",
                                posterPath: "/xi8Iu6qyTfyZVDVy60raIOYJJmk.jpg",
                                popularity: 10.8,
                                genres: ["Romance", "Action"],
                                originalLanguage: "en",
                                voteAverage: 8.2,
                                voteCount: 12354,
                                isFull: true)

    return MovieDetailView(movieModel: movieModel, modelContext: modelContext)
            .modelContainer(container)
}
