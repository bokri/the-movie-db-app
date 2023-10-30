//
//  Constants.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation

/**
 A utility enum containing constants for the application configuration.

 The `Constants` enum defines a set of static constants used throughout the application. These constants typically include URLs, key values, or other configuration settings.
*/
enum Constants {
    /**
       The base URL for accessing movie and TV show images from The Movie Database (TMDb).

       This constant provides the base URL for constructing image URLs to retrieve movie and TV show posters and related images from TMDb.
     */
    static let imagesBaseUrl = "https://image.tmdb.org/t/p/original"
    
    /**
     The maximum number of pages to be fetched when implementing infinite scrolling.
     
     This constant represents the maximum number of pages that can be fetched when implementing infinite scrolling in the app. It is used to limit the number of pages fetched to prevent excessive data retrieval.
     */
    static let maximumInfiniteScrollPages = 500
}
