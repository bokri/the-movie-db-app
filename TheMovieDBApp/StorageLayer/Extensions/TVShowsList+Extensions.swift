//
//  TVShowsList+Extensions.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation

extension TVShowsList {
    func toData() -> [TVShowModel] {
        return results.map { item in
            item.toItemData()
        }
    }
}