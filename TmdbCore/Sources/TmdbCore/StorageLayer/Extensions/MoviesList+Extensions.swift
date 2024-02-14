//
//  MoviesList+Extensions.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation

public extension MoviesList {
    /**
     An extension for converting decoded JSON `MoviesList` to `MovieModel` objects.
     
     - Returns: An array of `MovieModel` objects or an empty array.
     */
    func toData() -> [MovieDbModel] {
        return results.map { item in
            item.toItemData()
        }
    }
}

public extension Array where Element == MovieItem {
    func toData() -> [MovieDbModel] {
        return self.map({ $0.toItemData() })
    }
}
