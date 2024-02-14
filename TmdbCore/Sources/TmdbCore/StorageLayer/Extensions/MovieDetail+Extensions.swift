//
//  MovieDetail+Extensions.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation

public extension MovieDetail {
    /**
     Converts a `MovieDetail` instance to a detailed `MovieModel`.
     
     This method takes an instance of `MovieDetail` and transforms it into a more detailed `MovieModel`. It maps properties such as genres, original language, and vote count from the `MovieDetail` to the `MovieModel`. Additionally, it sets the `isFull` property to `true` to indicate a complete model.
     
     - Returns: A detailed `MovieModel` instance with enhanced movie information.
     */
    func toDetailData() -> MovieDbModel {
        let model = super.toItemData()
        model.genres.append(objectsIn: genres.map({ $0.name }))
        model.originalLanguage = originalLanguage
        model.voteCount = voteCount
        model.isFull = true
        return model
    }
}
