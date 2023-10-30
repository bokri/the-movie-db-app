//
//  MediaGenre.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation

/**
 A representation of a media genre.

 The `MediaGenre` struct represents a genre associated with a media item. It includes the genre's unique identifier and its name. This struct is used to decode JSON data that contains media genres.

 - Parameters:
    - id: The unique identifier of the genre.
    - name: The name of the genre.

 - Throws: An error if any required properties cannot be decoded.
 */
public struct MediaGenre: Codable {
    public let id: Int
    public let name: String
}
