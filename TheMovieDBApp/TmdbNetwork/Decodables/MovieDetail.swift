//
//  MovieDetail.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation

class MovieDetail: MovieItem {
    let genres: [MediaGenre]
    let originalLanguage: String
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
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
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        genres = try container.decode([MediaGenre].self, forKey: .genres)
        originalLanguage = try container.decode(String.self, forKey: .originalLanguage)
        voteCount = try container.decode(Int.self, forKey: .voteCount)
        
        try super.init(from: container.superDecoder())
    }
}
