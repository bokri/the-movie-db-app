//
//  MoviesRepository.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation
import SwiftData

/**
 A repository responsible for managing and synchronizing movie data.

 The `MoviesRepository` conforms to the `MediaRepositoryProtocol`, specifying `MovieModel` as the media type it deals with. It provides methods for synchronizing new movie data and updating local movie entities.

 - Note: This repository uses a generic data access object (`GenericDataAccessObject`) to interact with the local data store.

 */
public struct MoviesRepository: MediaRepositoryProtocol {
    public typealias MediaType = MovieModel
    
    /// The generic data access object used to interact with the local data store.
    private let dao: GenericDataAccessObject<MovieModel>
    
    /**
     Initializes a new `MoviesRepository` with the provided model context.
     
     - Parameter context: A `ModelContext` for data access and management.
     */
    public init(context: ModelContext) {
        self.dao = GenericDataAccessObject(context: context)
    }
    
    internal init(dao: GenericDataAccessObject<MovieModel>) {
        self.dao = dao
    }

    /**
     Synchronizes new movie data with the local movie repository.
     
     This method fetches existing movie data from the local repository and updates it with new data. Any new movies not present in the local repository are added.
     
     - Parameter newMedias: An array of new movie entities to synchronize with the local data store.
     
     - Throws: An error if there is an issue with data synchronization or storage.
     */
    public func sync(_ newMedias: [MediaType]) async {
        do {
            // Fetch existing movie data from the local data store
            var oldDatas = try dao.getAll()
            
            // Update local movie entities with new data and get new, unsaved entities
            let notAlreadySaved = updateLocalMedia(with: newMedias, in: &oldDatas)
            
            // Create new items in the data store
            dao.create(notAlreadySaved)
            
            // Save changes to the local data store
            try dao.save()
        } catch {
            Logger.error("Error on synchronizing datastore with : \(error.localizedDescription)")
        }
    }
}
