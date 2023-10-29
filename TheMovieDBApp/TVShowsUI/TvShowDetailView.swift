//
//  TvShowDetailView.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation
import SwiftUI

struct TvShowDetailView: View {

    var tvShowId: Int

    var body: some View {
        Text("TvShow : \(tvShowId)")
    }
}

#Preview {
    TvShowDetailView(tvShowId: 550)
}
