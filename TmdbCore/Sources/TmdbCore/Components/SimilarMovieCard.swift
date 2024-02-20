//
//  SimilarMovieCard.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation
import SwiftUI

public struct SimilarMovieCard: View {
    
    // MARK: - Properties
    
    let similarMovie: MovieEntity
    
    // MARK: - Constructors
    
    /**
     Initializes a `SimilarMovieCard` view with information about a similar movie.
     
     - Parameter similarMovie: The `MovieModel` object representing the similar movie's details to be displayed.
     */
    public init(similarMovie: MovieEntity) {
        self.similarMovie = similarMovie
    }
    
    // MARK: - SwiftUI
    
    public var body: some View {
        VStack(alignment: .leading) {
            PosterImageView(imageURL: Constants.imagesBaseUrl + similarMovie.posterPath, width: 120, height: 180)
                .cornerRadius(10)
            
            Text(similarMovie.title)
                .font(.headline)
                .fontWeight(.bold)
                .lineLimit(1)
            
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
