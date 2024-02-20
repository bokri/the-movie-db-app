//
//  MovieEntity.swift
//  
//
//  Created by Aymen Bokri on 14/02/2024.
//

import Foundation

public struct MovieEntity: Identifiable, Equatable {

    // MARK: - Properties
    
    public let id: Int
    public let title: String
    public let overview: String
    public let releaseDate: String
    public let posterPath: String
    public let popularity: Float
    public let genres: [String]
    public let originalLanguage: String?
    public let voteAverage: Float?
    public let voteCount: Int?
    public let isFull: Bool
    
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
    
    // MARK: - Equatable
    
    public static func == (lhs: MovieEntity, rhs: MovieEntity) -> Bool {
        lhs.id == rhs.id && lhs.isFull == rhs.isFull
    }
}
