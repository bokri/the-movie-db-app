//
//  MoviesListView.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import SwiftUI
import SwiftData
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
    init(moviesManager: MoviesManagerProtocol) {
        let presenter = MoviesListPresenter(moviesManager: moviesManager)
        self._presenter = State(initialValue: presenter)
    }
    
    // MARK: - SwiftUI
    
    var body: some View {
        NavigationView {
            Group {
                if dbMovieItems.isEmpty && presenter.isOnError == false {
                    // Display a loading indicator
                    ProgressView()
                } else if presenter.isOnError {
                    // Display the error screen
                    ErrorScreen() {
                        // Retry button action
                        await presenter.getMovies(page: presenter.currentPage)
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
            SearchView(moviesManager: presenter.moviesManager, isPresented: $presenter.isSearchActive)
        }
        
        .task {
            await presenter.getMovies(page: presenter.currentPage)
        }
    }
    
    var moviesList: some View {
        List {
            ForEach(dbMovieItems) { item in
                NavigationLink {
                    MovieDetailView(movieModel: item, moviesManager: presenter.moviesManager)
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
