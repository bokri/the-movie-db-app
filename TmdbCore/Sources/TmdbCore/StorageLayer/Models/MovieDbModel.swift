//
//  Movie.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation
import RealmSwift

public class MovieDbModel: Object, Identifiable {
    
    // MARK: - Properties

    @Persisted(primaryKey: true) public var id: Int
    @Persisted public var title: String
    @Persisted public var overview: String
    @Persisted public var releaseDate: String
    @Persisted public var posterPath: String
    @Persisted public var popularity: Float
    @Persisted public var genres: List<String>
    @Persisted public var originalLanguage: String?
    @Persisted public var voteAverage: Float?
    @Persisted public var voteCount: Int?
    @Persisted public var isFull: Bool
    
    // MARK: - Constructors
    
    public func setupProperties(
        id: Int,
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
        self.genres = List()
        self.genres.append(objectsIn: genres)
        self.originalLanguage = originalLanguage
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.isFull = isFull
    }
}
