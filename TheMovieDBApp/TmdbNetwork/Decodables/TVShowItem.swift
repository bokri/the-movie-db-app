//
//  TVShowItem.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation

class TVShowItem: Codable {
    let id: Int
    let name: String
    let overview: String
    let firstAirDate: String
    let posterPath: String
    let popularity: Float
    let voteAverage: Float
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case overview
        case firstAirDate = "first_air_date"
        case posterPath = "poster_path"
        case popularity
        case voteAverage = "vote_average"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        overview = try container.decode(String.self, forKey: .overview)
        firstAirDate = try container.decode(String.self, forKey: .firstAirDate)
        posterPath = try container.decode(String.self, forKey: .posterPath)
        popularity = try container.decode(Float.self, forKey: .popularity)
        voteAverage = try container.decode(Float.self, forKey: .voteAverage)
    }
}
