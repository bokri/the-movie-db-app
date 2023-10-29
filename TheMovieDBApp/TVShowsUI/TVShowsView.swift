//
//  TVShowsView.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation
import SwiftUI
import SwiftData

struct TVShowsView: View {
    
    @Environment(\.modelContext) var modelContext
    @State private var presenter: TVShowsPresenter
    @Query private var items: [TVShowModel]
    
    init(modelContext: ModelContext) {
        let presenter = TVShowsPresenter(modelContext: modelContext)
        self._presenter = State(initialValue: presenter)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink(destination: TvShowDetailView(tvShowId: item.id)) {
                        Text("\(item.name)")
                    }
                }
            }
            .navigationTitle(String(localized: "tvShowsTabTitle"))
        }
        .task {
            await presenter.getTvShows(page: 1)
        }
    }
}
