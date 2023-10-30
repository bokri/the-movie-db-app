//
//  MediaRepositoryProtocol.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation

/**
 A protocol defining the requirements for a media repository.

 A media repository is responsible for managing and synchronizing media entities of a specific type, where each entity conforms to the `Identifiable` protocol.

 The `MediaRepositoryProtocol` provides methods for synchronizing new media data, as well as updating and managing local media entities.

 - Note: The associated type `MediaType` should represent the type of media entities this repository deals with.
 */
public protocol MediaRepositoryProtocol {
    associatedtype MediaType
    
    /**
     Synchronizes new media data with the local media store.
     
     - Parameter newMedias: An array of new media entities to be synchronized with the local media store.
     
     - Throws: An error if there is an issue with the synchronization process.
     */
    func sync(_ newMedias: [MediaType]) async
    
    /**
     Updates local media entities with new data and returns new, unsaved entities.
     
     This method updates local media entities based on matching IDs with new data. It also identifies new media entities that are not present in the local data store.
     
     - Parameters:
     - newMedias: An array of new media entities to update the local data store.
     - localMedias: A reference to the array of local media entities to be updated.
     
     - Returns: An array of new media entities that are not present in the local data store.
     
     - Note: This method assumes that media entities conform to the `Identifiable` protocol.
     */
    func updateLocalMedia(with newMedias: [MediaType], in localMedias: inout [MediaType]) -> [MediaType]
}

// MARK: - Default Implementation

public extension MediaRepositoryProtocol where MediaType: Identifiable {
    func updateLocalMedia(with newMedias: [MediaType], in localMedias: inout [MediaType]) -> [MediaType] {
        // Update oldDatas with new values based on matching IDs
        for (index, oldData) in localMedias.enumerated() {
            if let matchingNewMedia = newMedias.first(where: { $0.id == oldData.id }) {
                localMedias[index] = matchingNewMedia
            }
        }
        
        // Find new items (notAlreadySaved) that are not present in oldDatas
        let notAlreadySaved = newMedias.filter { newMedia in
            !localMedias.contains { $0.id == newMedia.id }
        }
        
        return notAlreadySaved
    }
}
