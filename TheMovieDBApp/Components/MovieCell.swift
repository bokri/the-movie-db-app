//
//  MediaCell.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation
import SwiftUI

/**
 A SwiftUI view for displaying information about a movie in a cell layout.

 The `MovieCell` struct is a SwiftUI view designed for displaying information about a movie in a cell-like layout. It includes the movie's poster, title, release year, overview, and vote average. The view allows for a compact presentation of movie details.
 
 
 # Parameters:
 - `movie`: The `MovieModel` object representing the movie's details to be displayed.

 # Subviews:
 The `MovieCell` view contains the following subviews:
 - `PosterImageView`: For displaying the movie's poster.
 - `Text`: For displaying the movie's title.
 - `Text`: For displaying the movie's release year.
 - `Text`: For displaying the movie's overview (limited to two lines).
 - `HStack`: For displaying the vote average with a star icon.

 # See Also:
 - `MovieModel`: The data model representing a movie's details.
 - `PosterImageView`: A custom view for displaying movie posters.
 - `Constants`: A utility enum containing application constants.

 For more information on using the `MovieCell` view and its subviews, refer to the relevant parts of the application's code or user interface.

 */
struct MovieCell: View {
    
    // MARK: - Properties

    let movie: MovieModel
    
    // MARK: - Constructors
    
    /**
     Initializes a `MovieCell` view with information about a movie.
     
     - Parameter movie: The `MovieModel` object representing the movie's details to be displayed.
     */
    init(movie: MovieModel) {
        self.movie = movie
    }
    
    // MARK: - SwiftUI
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            PosterImageView(imageURL: Constants.imagesBaseUrl + movie.posterPath, width: 80, height: 120)
            
            VStack(alignment: .leading, spacing: 4) {
                // Movie Title
                Text(movie.title)
                    .font(.headline)
                
                // Year of Release
                Text(movie.releaseDate.formatDateString())
                    .font(.subheadline)
                
                // Movie Overview (maximum 2 lines)
                Text(movie.overview)
                    .font(.caption)
                    .lineLimit(2)

                if let voteAverage = movie.voteAverage {
                    HStack {
                        // Star Icon
                        Image(systemName: "star.fill")
                            .font(.subheadline)
                            .foregroundColor(.yellow)
                        
                        // Vote Average
                        Text(String(format: "%.1f", voteAverage))
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            Spacer()
        }
        .padding(12)
    }
}
