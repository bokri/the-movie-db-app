//
//  TvShowCell.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation
import SwiftUI

struct TvShowCell: View {
    let tvShow: TVShowModel

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            PosterImageView(imageURL: Constants.imagesBaseUrl + tvShow.posterPath, width: 80, height: 120)
            
            VStack(alignment: .leading, spacing: 4) {
                // Movie Title
                Text(tvShow.name)
                    .font(.headline)
                
                // Year of Release
                Text(tvShow.firstAirDate.formatDateString())
                    .font(.subheadline)
                
                // Movie Overview (maximum 2 lines)
                Text(tvShow.overview)
                    .font(.caption)
                    .lineLimit(2)

                if let voteAverage = tvShow.voteAverage {
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
