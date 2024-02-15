//
//  SearchView.swift
//  TheMovieDbApp
//
//  Created by Aymen Bokri on 15/02/2024.
//

import Foundation
import SwiftUI
import SwiftData
import TmdbCore

struct SearchView: View {
    
    // MARK: - Properties
    
    @State private var presenter: SearchPresenter
    @Binding var isPresented: Bool
    
    // MARK: - Constructors
    
    /**
     Initializes a `MoviesListView` with the provided `ModelContext`.
     
     - Parameter modelContext: The `ModelContext` object for managing data in the app.
     */
    init(moviesManager: MoviesManagerProtocol, isPresented: Binding<Bool>) {
        let presenter = SearchPresenter(moviesManager: moviesManager)
        self._presenter = State(initialValue: presenter)
        self._isPresented = isPresented
    }
    
    // MARK: - SwiftUI
    
    var body: some View {
        NavigationStack {
            Group {
                searchList
            }
            .searchable(text: $presenter.searchText, isPresented: $presenter.searchIsActive)
            .navigationTitle(String(localized: "searchTabTitle"))
                .toolbar {
                    Button(String(localized: "btn.close")) {
                        isPresented = false
                    }
                }
        }
        .onSubmit(of: .search) {
            Task {
                await presenter.searchMovies()
            }
        }
    }
    
    var searchList: some View {
        List {
            ForEach(presenter.searchMovies) { item in
                NavigationLink {
                    MovieDetailView(movieModel: item, moviesManager: presenter.moviesManager)
                } label: {
                    MovieCell(movie: item)
                }
            }
        }
    }
}
