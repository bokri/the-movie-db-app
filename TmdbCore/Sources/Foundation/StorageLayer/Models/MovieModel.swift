//
//  Movie.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation
import SwiftData

@Model
public class MovieModel: Identifiable {
    
    // MARK: - Properties

    @Attribute(.unique)
    public var id: Int
    public var title: String
    public var overview: String
    public var releaseDate: String
    public var posterPath: String
    public var popularity: Float
    public var genres: [String]
    public var originalLanguage: String?
    public var voteAverage: Float?
    public var voteCount: Int?
    public var isFull: Bool
    
    // MARK: - Constructors
    
    public init(id: Int,
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
