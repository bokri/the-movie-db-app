//
//  TVShowModel.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation
import SwiftData

@Model
class TVShowModel: Identifiable {
    @Attribute(.unique)
    var id: Int
    var name: String
    var overview: String
    var firstAirDate: String
    var posterPath: String
    var popularity: Float
    var genres: [MediaGenreModel]
    var originalLanguage: String
    var voteAverage: Float
    var voteCount: Int
    var numberOfSeasons: Int
    var numberOfEpisodes: Int
    var isFull: Bool

    init(id: Int,
         name: String,
         overview: String,
         firstAirDate: String,
         posterPath: String,
         popularity: Float,
         genres: [MediaGenreModel],
         originalLanguage: String,
         voteAverage: Float,
         voteCount: Int,
         numberOfSeasons: Int,
         numberOfEpisodes: Int,
         isFull: Bool) {
        self.id = id
        self.name = name
        self.overview = overview
        self.firstAirDate = firstAirDate
        self.posterPath = posterPath
        self.popularity = popularity
        self.genres = genres
        self.originalLanguage = originalLanguage
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.numberOfSeasons = numberOfSeasons
        self.numberOfEpisodes = numberOfEpisodes
        self.isFull = isFull
    }
}
