//
//  TVShowDetail.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation

class TVShowDetail: TVShowItem {
    let genres: [MediaGenre]
    let numberOfSeasons: Int
    let numberOfEpisodes: Int
    let originalLanguage: String
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case genres
        case originalLanguage = "original_language"
        case voteCount = "vote_count"
        case numberOfSeasons = "number_of_seasons"
        case numberOfEpisodes = "number_of_episodes"
        // Inherit the super class's CodingKeys
        case id
        case name
        case overview
        case firstAirDate
        case posterPath
        case popularity
        case voteAverage
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        genres = try container.decode([MediaGenre].self, forKey: .genres)
        numberOfSeasons = try container.decode(Int.self, forKey: .numberOfSeasons)
        numberOfEpisodes = try container.decode(Int.self, forKey: .numberOfEpisodes)
        originalLanguage = try container.decode(String.self, forKey: .originalLanguage)
        voteCount = try container.decode(Int.self, forKey: .voteCount)
        
        try super.init(from: container.superDecoder())
    }
}
