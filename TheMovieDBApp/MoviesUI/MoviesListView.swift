//
//  MoviesListView.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import SwiftUI
import SwiftData

struct MoviesListView: View {
    
    @Environment(\.modelContext) var modelContext
    @State private var presenter: MoviesListPresenter
    @Query(sort: \MovieModel.popularity, order: .reverse) private var items: [MovieModel]

    
    init(modelContext: ModelContext) {
        let presenter = MoviesListPresenter(modelContext: modelContext)
        self._presenter = State(initialValue: presenter)
    }
    
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
