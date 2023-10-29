//
//  TVShowItem.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation

extension TVShowItem {
    func toItemData() -> TVShowModel {
        return TVShowModel(id: id,
                           name: name,
                           overview: overview,
                           firstAirDate: firstAirDate,
                           posterPath: posterPath,
                           popularity: popularity,
                           genres: [],
                           originalLanguage: nil,
                           voteAverage: voteAverage,
                           voteCount: nil,
                           numberOfSeasons: nil,
                           numberOfEpisodes: nil,
                           isFull: false)
    }
}
