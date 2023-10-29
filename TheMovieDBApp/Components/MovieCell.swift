//
//  MediaCell.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation
import SwiftUI

struct MovieCell: View {
    let movie: MovieModel

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
