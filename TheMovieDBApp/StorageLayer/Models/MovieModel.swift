//
//  Movie.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation
import SwiftData

@Model
class MovieModel: Identifiable {
    @Attribute(.unique)
    var id: Int
    var title: String
    var overview: String
    var releaseDate: String
    var posterPath: String
    var popularity: Float
    var genres: [String]
    var originalLanguage: String?
    var voteAverage: Float?
    var voteCount: Int?
    var isFull: Bool
    
    init(id: Int,
         title: String,
         overview: String,
         releaseDate: String,
         posterPath: String,
         popularity: Float,
         genres: [String],
         originalLanguage: String?,
         voteAverage: Float?,
         voteCount: Int?,
         isFull: Bool) {
        self.id = id
        self.title = title
        self.overview = overview
        self.releaseDate = releaseDate
        self.posterPath = posterPath
        self.popularity = popularity
        self.genres = genres
        self.originalLanguage = originalLanguage
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.isFull = isFull
    }
}
