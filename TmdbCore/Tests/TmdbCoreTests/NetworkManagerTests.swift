//
//  NetworkManagerTests.swift
//
//
//  Created by Aymen Bokri on 30/10/2023.
//

import Foundation
import XCTest
import OHHTTPStubs
import OHHTTPStubsSwift
@testable import TmdbCore

class NetworkManagerTests: XCTestCase {
    override func setUp() {
        HTTPStubs.removeAllStubs()
    }
    
    override func tearDown() {
        HTTPStubs.removeAllStubs()
        
        super.tearDown()
    }
    
    // Test fetching a list of movies from the TMDb API
    func testFetchMoviesList() async {
        // Stub an HTTP request to simulate the TMDb API response
        _ = stub(condition: isHost("api.themoviedb.org")) { (_) -> HTTPStubsResponse in
            
            if let bundlePath = Bundle.module.resourcePath {
                let stubPath = URL(fileURLWithPath: bundlePath).appendingPathComponent("moviesList.json").path
                return fixture(filePath: stubPath, headers: ["Content-Type": "application/json"])
            }
            
            return HTTPStubsResponse()
        }
        
        // Act: Fetch movies using the NetworkManager
        do {
            let movies: MoviesList = try await NetworkManager.shared.fetchData(TheMovieDbAPIEndpoint.topMovies(page: 1), type: MoviesList.self)
            
            
            // Assert: Verify the results
            XCTAssertEqual(movies.results.count, 20, "Expected 20 movies in the list")
            
            // Assertions for individual movie properties
            XCTAssertEqual(movies.results[0].id, 507089, "Incorrect movie ID")
            XCTAssertEqual(movies.results[0].title, "Five Nights at Freddy's", "Incorrect movie title")
            XCTAssertEqual(movies.results[0].overview, "Recently fired and desperate for work, a troubled young man named Mike agrees to take a position as a night security guard at an abandoned theme restaurant: Freddy Fazbear's Pizzeria. But he soon discovers that nothing at Freddy's is what it seems.")
            XCTAssertEqual(movies.results[0].releaseDate, "2023-10-25", "Incorrect release date")
            XCTAssertEqual(movies.results[0].posterPath, "/A4j8S6moJS2zNtRR8oWF08gRnL5.jpg", "Incorrect poster path")
            XCTAssertEqual(movies.results[0].popularity, 5089.151, "Incorrect popularity")
            XCTAssertEqual(movies.results[0].voteAverage, 8.5, "Incorrect vote average")
        } catch {
            XCTFail("Failed to fetch movies: \(error)")
        }
    }
    
    // Test fetching detailed information for a specific movie from the TMDb API
    func testFetchMovieDetail() async {
        // Stub an HTTP request to simulate the TMDb API response
        _ = stub(condition: isHost("api.themoviedb.org")) { (_) -> HTTPStubsResponse in

            if let bundlePath = Bundle.module.resourcePath {
                let stubPath = URL(fileURLWithPath: bundlePath).appendingPathComponent("movieDetail.json").path
                return fixture(filePath: stubPath, headers: ["Content-Type": "application/json"])
            }
            
            return HTTPStubsResponse()
        }
        
        // Act: Fetch movies using the NetworkManager
        do {
            let movieDetail: MovieDetail = try await NetworkManager.shared.fetchData(TheMovieDbAPIEndpoint.movieDetail(id: 500), type: MovieDetail.self)
            
            
            XCTAssertEqual(movieDetail.id, 500, "Incorrect movie ID")
            XCTAssertEqual(movieDetail.title, "Reservoir Dogs", "Incorrect movie title")
            XCTAssertEqual(movieDetail.overview, "A botched robbery indicates a police informant, and the pressure mounts in the aftermath at a warehouse. Crime begets violence as the survivors -- veteran Mr. White, newcomer Mr. Orange, psychopathic parolee Mr. Blonde, bickering weasel Mr. Pink and Nice Guy Eddie -- unravel.", "Incorrect movie overview")
            XCTAssertEqual(movieDetail.releaseDate, "1992-09-02", "Incorrect release date")
            XCTAssertEqual(movieDetail.posterPath, "/xi8Iu6qyTfyZVDVy60raIOYJJmk.jpg", "Incorrect poster path")
            XCTAssertEqual(movieDetail.popularity, 34.838, "Incorrect popularity")
            XCTAssertEqual(movieDetail.voteAverage, 8.131, "Incorrect vote average")
            XCTAssertEqual(movieDetail.voteCount, 13370, "Incorrect vote count")

            // Assert genre details
            XCTAssertEqual(movieDetail.genres.count, 2, "Incorrect number of genres")
            XCTAssertEqual(movieDetail.genres[0].id, 80, "Incorrect genre ID")
            XCTAssertEqual(movieDetail.genres[0].name, "Crime", "Incorrect genre name")
            XCTAssertEqual(movieDetail.genres[1].id, 53, "Incorrect genre ID")
            XCTAssertEqual(movieDetail.genres[1].name, "Thriller", "Incorrect genre name")

            // You can add more assertions for other movies if needed
        } catch {
            XCTFail("Failed to fetch movies: \(error)")
        }
    }
}
