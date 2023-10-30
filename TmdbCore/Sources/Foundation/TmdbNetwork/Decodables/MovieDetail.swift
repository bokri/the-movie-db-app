//
//  MovieDetail.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation

/**
 A detailed representation of a movie, extending the `MovieItem` class with additional details.

 The `MovieDetail` class represents a detailed view of a movie, extending the `MovieItem` class with specific details such as genres, original language, and vote count.

 - Parameters:
    - genres: An array of `MediaGenre` objects representing the genres of the movie.
    - originalLanguage: The original language in which the movie was released.
    - voteCount: The total count of votes received by the movie.

 - Inherited Properties:
    - id: The unique identifier of the movie.
    - title: The title of the movie.
    - overview: A brief description of the movie.
    - releaseDate: The release date of the movie.
    - posterPath: The path to the movie's poster image.
    - popularity: The popularity score of the movie.
    - voteAverage: The average vote rating of the movie.

 - Throws: An error if any required properties cannot be decoded.

 */
public class MovieDetail: MovieItem {
    public let genres: [MediaGenre]
    public let originalLanguage: String
    public let voteCount: Int

    public enum CodingKeys: String, CodingKey {
        case genres
        case originalLanguage = "original_language"
        case voteCount = "vote_count"
        // Inherit the super class's CodingKeys
        case id
        case title
        case overview
        case releaseDate
        case posterPath
        case popularity
        case voteAverage
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        genres = try container.decode([MediaGenre].self, forKey: .genres)
        originalLanguage = try container.decode(String.self, forKey: .originalLanguage)
        voteCount = try container.decode(Int.self, forKey: .voteCount)

        try super.init(from: decoder)
    }
}
