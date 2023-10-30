//
//  MovieItem.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation

/**
 A representation of a basic movie item with essential details.

 The `MovieItem` class represents the core information of a movie, including its unique identifier, title, overview, release date, poster path, popularity score, and average vote rating. This class is used to decode JSON data that contains basic movie details.

 - Parameters:
    - id: The unique identifier of the movie.
    - title: The title of the movie.
    - overview: A brief description of the movie.
    - releaseDate: The release date of the movie.
    - posterPath: The path to the movie's poster image.
    - popularity: The popularity score of the movie.
    - voteAverage: The average vote rating of the movie.

 - Throws: An error if any required properties cannot be decoded.
 */
class MovieItem: Codable {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String
    let posterPath: String
    let popularity: Float
    let voteAverage: Float
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case popularity
        case voteAverage = "vote_average"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        overview = try container.decode(String.self, forKey: .overview)
        releaseDate = try container.decode(String.self, forKey: .releaseDate)
        posterPath = try container.decode(String.self, forKey: .posterPath)
        popularity = try container.decode(Float.self, forKey: .popularity)
        voteAverage = try container.decode(Float.self, forKey: .voteAverage)
    }
}
