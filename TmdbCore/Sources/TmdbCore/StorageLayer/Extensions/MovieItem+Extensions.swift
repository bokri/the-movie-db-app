//
//  MovieItem+Extensions.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation

public extension MovieItem {

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
