//
//  PosterImageView.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import SwiftUI
import Kingfisher

struct PosterImageView: View {
    let imageURL: String
    let width: CGFloat?
    let height: CGFloat
    
    var body: some View {
        KFImage(URL(string: imageURL))
            .placeholder {
                ProgressView()
            }
            .resizable()
            .onSuccess { _ in }
            .onFailure { error in
                // Change it with logger
                print("Image download failed with error: \(error)")
            }
            .frame(maxWidth: width ?? .infinity, maxHeight: height)
            .cornerRadius(10)
    }
}
