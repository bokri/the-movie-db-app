//
//  MovieDetail+Extensions.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation

extension MovieDetail {
    func toDetailData() -> MovieModel {
        let model = super.toItemData()
        model.genres = genres.map({ $0.toData() })
        model.originalLanguage = originalLanguage
        model.voteCount = voteCount
        model.isFull = true
        return model
    }
}
