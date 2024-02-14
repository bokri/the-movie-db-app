//
//  MovieItem+Extensions.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation

public extension MovieItem {
    /**
     An extension for converting a `MovieItem` instance to a `MovieModel`.
     
     This extension provides a method to convert a `MovieItem` instance into a `MovieModel` instance. It allows for easy transformation of data between related model classes in the application.
     
     - Returns: A `MovieModel` instance representing the same movie information with optional properties set to default values.
     */
    func toItemData() -> MovieDbModel {
        let movieDb = MovieDbModel()
        movieDb.setupProperties(
            id: id,
            title: title,
            overview: overview,
            releaseDate: releaseDate,
            posterPath: posterPath,
            popularity: popularity,
            genres: [],
            originalLanguage: nil,
            voteAverage: voteAverage,
            voteCount: nil,
            isFull: false)
        return movieDb
    }
}
