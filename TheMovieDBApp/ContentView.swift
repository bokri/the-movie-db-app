//
//  ContentView.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            MoviesListView()
                .tabItem {
                    Label(String(localized: "moviesTabTitle"), systemImage: "film")
                }
            
            TVShowsView()
                .tabItem {
                    Label(String(localized: "tvShowsTabTitle"), systemImage: "tv")
                }
        }
    }
}

#Preview {
    ContentView()
}
