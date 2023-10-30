//
//  File.swift
//  
//
//  Created by Aymen Bokri on 30/10/2023.
//

import Foundation
import XCTest
import SwiftData
@testable import TmdbCore

/**
 Unit tests for the `MoviesRepository` class.
 */
class MovieRepositoryTests: XCTestCase {
    
    /**
     Test the synchronization of new movie data with the local movie repository.
     */
    func testSync() async {
        // Create a model container configuration for in-memory testing
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        
        // Create a model container for the `MovieModel` type with the specified configuration
        let container = try! ModelContainer(for: MovieModel.self, configurations: config)
        
        // Create a model context for data access
        let modelContext = ModelContext(container) // You can use a mock context for testing
        
        // Create a mock data access object for `MovieModel`
        let mockDataAccessObject = MockDataAccessObject<MovieModel>(context: modelContext)
        
        // Create a movies repository with the mock data access object
        let moviesRepository = MoviesRepository(dao: mockDataAccessObject)
        
        // Create some sample MovieModel objects
        let movie1 = MovieModel(id: 1, title: "Movie 1", overview: "Overview of Movie 1", releaseDate: "2023-10-29", posterPath: "/path1", popularity: 8.5, genres: ["Action", "Adventure"], originalLanguage: "English", voteAverage: 9.0, voteCount: 100, isFull: true)
        let movie2 = MovieModel(id: 2, title: "Movie 2", overview: "Overview of Movie 2", releaseDate: "2023-10-30", posterPath: "/path2", popularity: 7.8, genres: ["Drama", "Romance"], originalLanguage: "French", voteAverage: 8.2, voteCount: 75, isFull: false)
        let movie3 = MovieModel(id: 3, title: "Movie 3", overview: "Overview of Movie 3", releaseDate: "2023-10-31", posterPath: "/path3", popularity: 6.9, genres: ["Comedy"], originalLanguage: "Spanish", voteAverage: 7.0, voteCount: 50, isFull: true)
        
        // Put the MovieModel objects in an array
        let movieModels: [MovieModel] = [movie1, movie2, movie3]
        
        // Set the desired return value for getAll to return the sample MovieModels
        mockDataAccessObject.getAllReturnValue = movieModels
        
        // Create two new MovieModel objects
        let movie4 = MovieModel(id: 4, title: "Movie 4", overview: "Overview of Movie 4", releaseDate: "2023-11-01", posterPath: "/path4", popularity: 7.2, genres: ["Horror", "Mystery"], originalLanguage: "English", voteAverage: 7.5, voteCount: 60, isFull: false)
        let movie5 = MovieModel(id: 5, title: "Movie 5", overview: "Overview of Movie 5", releaseDate: "2023-11-02", posterPath: "/path5", popularity: 8.0, genres: ["Science Fiction", "Action"], originalLanguage: "English", voteAverage: 8.8, voteCount: 90, isFull: true)
        
        // Create an array of new MovieModels
        let newMovieModels: [MovieModel] = [movie4, movie5]
        
        // Call the sync function with the new MovieModels
        await moviesRepository.sync(newMovieModels)
        
        // Assert that the create and save functions are called as expected
        XCTAssertTrue(mockDataAccessObject.createCalled, "create should be called")
        XCTAssertTrue(mockDataAccessObject.saveCalled, "save should be called")
    }
}
