//
//  File.swift
//  
//
//  Created by Aymen Bokri on 14/02/2024.
//

import Foundation

public extension MovieDbModel {
    
    func toEntity() -> MovieEntity {
        return MovieEntity(id: id,
                           title: title,
                           overview: overview,
                           releaseDate: releaseDate,
                           posterPath: posterPath,
                           popularity: popularity,
                           genres: Array(genres),
                           originalLanguage: originalLanguage,
                           voteAverage: voteAverage,
                           voteCount: voteCount,
                           isFull: isFull)
    }
}

public extension Array where Element == MovieDbModel {
    func toEntities() -> [MovieEntity] {
        return self.map({ $0.toEntity() })
    }
}
