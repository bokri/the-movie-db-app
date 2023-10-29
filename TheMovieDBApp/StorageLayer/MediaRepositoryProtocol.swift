//
//  MediaRepositoryProtocol.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation

protocol MediaRepositoryProtocol {
    associatedtype MediaType
    
    func sync(_ newMedias: [MediaType]) async
    func updateLocalMedia(with newMedias: [MediaType], in localMedias: inout [MediaType]) -> [MediaType]
}

extension MediaRepositoryProtocol where MediaType: Identifiable {
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
