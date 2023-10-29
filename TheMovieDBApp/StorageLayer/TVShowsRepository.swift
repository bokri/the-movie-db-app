//
//  TVShowsRepository.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation
import SwiftData

struct TVShowsRepository: MediaRepositoryProtocol {
    typealias MediaType = TVShowModel
    
    private let repository: GenericRepository<TVShowModel>

    init(context: ModelContext) {
        self.repository = GenericRepository(context: context)
    }
    
    func sync(_ newMedias: [MediaType]) async {
        do {
            var oldDatas = try repository.getAll()

            let notAlreadySaved = updateLocalMedia(with: newMedias, in: &oldDatas)
            
            // Create new items in the repository
            repository.create(notAlreadySaved)
            
            // Save changes to the repository
            try repository.save()
        } catch {
            // Log error
        }
    }
}
