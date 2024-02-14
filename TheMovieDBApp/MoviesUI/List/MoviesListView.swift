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
                if presenter.searchIsActive == false {
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
                } else {
                    searchList
                }
            }.navigationTitle(String(localized: "moviesTabTitle"))
        }
        .searchable(text: $presenter.searchText, isPresented: $presenter.searchIsActive)
        .onChange(of: presenter.searchIsActive, { oldValue, newValue in
            if !newValue {
                presenter.emptySearchMovies()
            }
        })
        .onChange(of: presenter.searchText, { oldValue, newValue in
            if newValue.isEmpty {
                presenter.emptySearchMovies()
            }
        })
        .onSubmit(of: .search) {
            Task {
                await presenter.searchMovies()
            }
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
    
    var searchList: some View {
        List {
            ForEach(presenter.searchMovies) { item in
                MovieCell(movie: item)
            }
        }
    }
}
