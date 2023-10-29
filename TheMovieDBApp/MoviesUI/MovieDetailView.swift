//
//  MovieDetailView.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import SwiftUI

struct MovieDetailView: View {

    var movieId: Int

    var body: some View {
        Text("Movie : \(movieId)")
    }
}

#Preview {
    MovieDetailView(movieId: 550)
}
