//
//  MoviesList+Extensions.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation

extension MoviesList {
    func toData() -> [MovieModel] {
        return results.map { item in
            item.toItemData()
        }
    }
}
