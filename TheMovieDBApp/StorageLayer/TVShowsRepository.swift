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
            var localMedias = try repository.getAll()
            updateLocalMedia(with: newMedias, in: &localMedias)
            repository.create(newMedias)
            
            try repository.save()
        } catch {
            // Log error
        }
    }
}
