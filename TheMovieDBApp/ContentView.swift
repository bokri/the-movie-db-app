//
//  ContentView.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        TabView {
            MoviesListView(modelContext: modelContext)
                .environment(\.modelContext, modelContext)
                .tabItem {
                    Label(String(localized: "moviesTabTitle"), systemImage: "film")
                }
            
            TVShowsView(modelContext: modelContext)
                .environment(\.modelContext, modelContext)
                .tabItem {
                    Label(String(localized: "tvShowsTabTitle"), systemImage: "tv")
                }
        }
    }
}

#Preview {
    ContentView()
}
