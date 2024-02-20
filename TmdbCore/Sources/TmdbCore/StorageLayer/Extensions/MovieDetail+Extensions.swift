//
//  MovieDetail+Extensions.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation

public extension MovieDetail {

    func toDetailData() -> MovieDbModel {
        let model = super.toItemData()
        model.genres.append(objectsIn: genres.map({ $0.name }))
        model.originalLanguage = originalLanguage
        model.voteCount = voteCount
        model.isFull = true
        return model
    }
}
