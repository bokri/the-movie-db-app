//
//  TheMovieDBAppApp.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import SwiftUI
import SwiftData

@main
struct TheMovieDBAppApp: App {
    var sharedModelContainer: ModelContainer = {
        let schemas = Schema([
            MovieModel.self, TVShowModel.self, MediaGenreModel.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schemas, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schemas, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(sharedModelContainer)
    }
}
