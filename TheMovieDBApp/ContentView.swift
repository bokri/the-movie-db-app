//
//  ContentView.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import SwiftUI
import SwiftData
import TmdbCore

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        MoviesListView(modelContext: modelContext)
            .environment(\.modelContext, modelContext)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: MovieModel.self, configurations: config)
    let modelContext = ModelContext(container)
    
    return ContentView()
        .modelContainer(container)
}
