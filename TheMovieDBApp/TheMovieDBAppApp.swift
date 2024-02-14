//
//  TheMovieDBAppApp.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import SwiftUI
import SwiftData
import TmdbCore

/**
 The main entry point of the The Movie Database (TMDb) SwiftUI app.

 The `TheMovieDBAppApp` structure is the starting point of the SwiftUI app, which initializes the core components of the app and defines the app's main scene.

 - Note: This structure initializes a `ModelContainer` for managing persistent data storage using the SwiftData framework, including the schemas and model configurations required for storing and retrieving data related to the app's movie listings.
*/
@main
struct TheMovieDBAppApp: App {
    
    // MARK: - SwiftUI

    /// The entry point for defining the app's main scene.
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
