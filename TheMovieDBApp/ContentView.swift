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
    
    private var moviesService: MoviesServiceProtocol
    
    init() {
        moviesService = MoviesService()
    }
    
    var body: some View {
        MoviesListView(moviesService: moviesService)
    }
}
