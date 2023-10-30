//
//  SimilarMovieCard.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation
import SwiftUI

/**
 A SwiftUI view for displaying information about a similar movie in a card layout.
 
 The `SimilarMovieCard` struct is a SwiftUI view designed for displaying information about a movie similar to the main movie, presented in a card-like layout. It includes the similar movie's poster, title, and vote average.
 
 
 # Parameters:
 - `similarMovie`: The `MovieModel` object representing the details of the similar movie to be displayed.
 
 # Subviews:
 The `SimilarMovieCard` view contains the following subviews:
 - `PosterImageView`: For displaying the similar movie's poster.
 - `Text`: For displaying the similar movie's title.
 - `HStack`: For displaying the vote average with a star icon.
 
 # See Also:
 - `MovieModel`: The data model representing movie details.
 - `PosterImageView`: A custom view for displaying movie posters.
 - `Constants`: A utility enum containing application constants.
 
 For more information on using the `SimilarMovieCard` view and its subviews, refer to the relevant parts of the application's code or user interface.
 
 */
struct SimilarMovieCard: View {
    
    // MARK: - Properties
    
    let similarMovie: MovieModel
    
    // MARK: - Constructors
    
    /**
     Initializes a `SimilarMovieCard` view with information about a similar movie.
     
     - Parameter similarMovie: The `MovieModel` object representing the similar movie's details to be displayed.
     */
    init(similarMovie: MovieModel) {
        self.similarMovie = similarMovie
    }
    
    // MARK: - SwiftUI
    
    var body: some View {
        VStack(alignment: .leading) {
            PosterImageView(imageURL: Constants.imagesBaseUrl + similarMovie.posterPath, width: 120, height: 180)
                .cornerRadius(10)
            
            Text(similarMovie.title)
                .font(.headline)
                .fontWeight(.bold)
                .lineLimit(2)
            
            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                Text(String(format: "%.1f", similarMovie.voteAverage ?? 0.0))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .frame(width: 120)
        .padding(8)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 4)
    }
}
