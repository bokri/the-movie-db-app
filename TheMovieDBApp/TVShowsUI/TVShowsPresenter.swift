//
//  TVShowsPresenter.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation
import SwiftUI
import SwiftData

@Observable
class TVShowsPresenter {

    var modelContext: ModelContext
    var tvShowsRepository: TVShowsRepository
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.tvShowsRepository = TVShowsRepository(context: modelContext)
    }
    
    func getTvShows(page: Int) async {
        do {
            let remoteTvShows = try await NetworkManager.shared.fetchData(TheMovieDbAPIEndpoint.tvShows(page: page), type: TVShowsList.self)
               let data = remoteTvShows.toData()

            await tvShowsRepository.sync(data)
        } catch {
            // Log error
        }
    }
}
