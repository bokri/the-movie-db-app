//
//  MoviesList+Extensions.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation

public extension MoviesList {
    
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
