//
//  TVShowDetail+Extensions.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation

extension TVShowDetail {
    func toDetailData() -> TVShowModel {
        let model = super.toItemData()
        model.genres = genres.map({ $0.toData() })
        model.originalLanguage = originalLanguage
        model.voteCount = voteCount
        model.numberOfSeasons = numberOfSeasons
        model.numberOfEpisodes = numberOfEpisodes
        model.isFull = true
        return model
    }
}
