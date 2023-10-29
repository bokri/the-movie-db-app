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
                        MovieDetailView(movieId: item.id)
                    } label: {
                        Text(item.title)
                    }
                }
            }.navigationTitle(String(localized: "moviesTabTitle"))
        }.task {
            await presenter.getMovies(page: 1)
        }
    }
}
