//
//  SimilarMovieCard.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation
import SwiftUI

struct SimilarMovieCard: View {
    let similarMovie: MovieModel

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
