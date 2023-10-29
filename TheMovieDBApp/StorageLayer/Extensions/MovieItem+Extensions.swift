//
//  MovieItem+Extensions.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation

extension MovieItem {
    func toItemData() -> MovieModel {
        return MovieModel(id: id,
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
    }
}
