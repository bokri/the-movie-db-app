//
//  MediaGenre+Extensions.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation

extension MediaGenre {
    func toData() -> MediaGenreModel {
        return MediaGenreModel(id: id, name: name)
    }
}
