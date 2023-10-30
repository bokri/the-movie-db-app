//
//  MoviesList.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation

/**
 The `MoviesList` struct is used to decode data from a remote source containing a list of `MovieItem` entities. It provides access to the list of movie items.

 - Note: This struct is Codable and can be used for decoding JSON data.

 - SeeAlso: `MovieItem`

 - Parameter results: An array of `MovieItem` entities representing movies retrieved from a remote data source.
 */
struct MoviesList: Codable {
    /// An array of `MovieItem` entities representing movies.
    let results: [MovieItem]
}
