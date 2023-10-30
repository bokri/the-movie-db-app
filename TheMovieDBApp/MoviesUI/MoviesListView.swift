//
//  MoviesListView.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import SwiftUI
import SwiftData

/**
 A SwiftUI view for displaying a list of movies with the ability to load more.

 The `MoviesListView` struct is a SwiftUI view designed to display a list of movies, where each movie is represented as a `MovieCell`. The view provides infinite scrolling functionality, automatically loading more movies as the user reaches the end of the list.

 # Parameters:
 - `modelContext`: The `ModelContext` object for managing data in the app.

 # Subviews:
 The `MoviesListView` view contains the following subviews:
 - `List`: A scrollable list of movie cells.
 - `MovieCell`: For displaying information about individual movies.
 - `NavigationLink`: For navigating to detailed movie information.
 - `MovieDetailView`: The view for displaying detailed information about a movie.

 # Functionality:
 The `MoviesListView` provides the following functionality:
 - Automatic infinite scrolling: When the user reaches the end of the list, more movies are loaded from the remote data source.

 # See Also:
 - `MovieModel`: The data model representing movie details.
 - `MovieCell`: A custom view for displaying movie details in a cell layout.
 - `MovieDetailView`: The view for displaying detailed information about a movie.
 - `MoviesListPresenter`: The presenter responsible for managing movie data.

 For more information on using the `MoviesListView` and its subviews, refer to the relevant parts of the application's code or user interface.

 */
struct MoviesListView: View {
    
    // MARK: - Properties
    
    @Environment(\.modelContext) var modelContext
    @State private var presenter: MoviesListPresenter
    @Query(sort: \MovieModel.popularity, order: .reverse) private var items: [MovieModel]
    
    // MARK: - Constructors

    /**
     Initializes a `MoviesListView` with the provided `ModelContext`.
     
     - Parameter modelContext: The `ModelContext` object for managing data in the app.
     */
    init(modelContext: ModelContext) {
        let presenter = MoviesListPresenter(modelContext: modelContext)
        self._presenter = State(initialValue: presenter)
    }
    
    // MARK: - SwiftUI
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        MovieDetailView(movieModel: item, modelContext: modelContext)
                            .environment(\.modelContext, modelContext)
                    } label: {
                        MovieCell(movie: item)
                    }
                    .task {
                        if item == items.last && !presenter.isLoading {
                            // Fetch more data when the last cell is visible
                            await presenter.fetchMoreMovies()
                        }
                    }
                }
            }.navigationTitle(String(localized: "moviesTabTitle"))
        }.task {
            await presenter.getMovies(page: presenter.currentPage)
        }
    }
}
