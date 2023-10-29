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
    func updateLocalMedia(with newMedias: [MediaType], in localMedias: inout [MediaType])
}

extension MediaRepositoryProtocol where MediaType: Identifiable {
    func updateLocalMedia(with newMedias: [MediaType], in localMedias: inout [MediaType]) {
        for (index, localMedia) in localMedias.enumerated() {
            if let matchingNewMedia = newMedias.first(where: { $0.id == localMedia.id }),
               localMedia.id != matchingNewMedia.id
            {
                localMedias[index] = matchingNewMedia
            }
        }
    }
}
