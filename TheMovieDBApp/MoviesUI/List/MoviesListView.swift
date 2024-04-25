//
//  MoviesListView.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import SwiftUI
import TmdbCore

struct MoviesListView: View {
    
    // MARK: - Properties
    
    @State private var presenter: MoviesListPresenter

    @MoviesListner private var dbMovieItems: [MovieEntity]
    
    // MARK: - Constructors
    
    /**
     Initializes a `MoviesListView` with the provided `ModelContext`.
     
     - Parameter modelContext: The `ModelContext` object for managing data in the app.
     */
    init(moviesService: MoviesServiceProtocol) {
        let presenter = MoviesListPresenter(moviesService: moviesService)
        self._presenter = State(initialValue: presenter)
    }
    
    // MARK: - SwiftUI
    
    var body: some View {
        NavigationView {
            Group {
                if dbMovieItems.isEmpty {
                    if presenter.isOnError {
                        // Display the error screen
                        ErrorScreen() {
                            // Retry button action
                            await presenter.getMovies(page: presenter.currentPage)
                        }
                    } else {
                        // Display a loading indicator
                        ProgressView()
                    }
                } else {
                    moviesList
                }
            }
            .navigationTitle(String(localized: "moviesTabTitle"))
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        presenter.isSearchActive = true
                    }, label: {
                        Image(systemName: "magnifyingglass")
                    })
                }
            })
        }
        .sheet(isPresented: $presenter.isSearchActive) {
            // Present the search screen using a sheet
            SearchView(moviesService: presenter.moviesService, isPresented: $presenter.isSearchActive)
        }
        .task {
            await presenter.getMovies(page: presenter.currentPage)
        }
    }

    var moviesList: some View {
        List {
            ForEach(dbMovieItems) { item in
                NavigationLink {
                    MovieDetailView(movie: item, moviesService: presenter.moviesService)
                } label: {
                    MovieCell(movie: item)
                }
                .task {
                    if item == dbMovieItems.last && !presenter.isLoading {
                        // Fetch more data when the last cell is visible
                        await presenter.fetchMoreMovies()
                    }
                }
            }
        }
    }
}
