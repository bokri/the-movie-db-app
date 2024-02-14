//
//  MediaRepositoryProtocol.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation

public protocol MoviesRepositoryProtocol {
    func addAndUpdateMedias(_ medias: [MovieItem]) async throws
    func addAndUpdateMedia(_ media: MovieDetail) async throws
    func getMedias() async throws -> [MovieEntity]
    func getMedia(id: Int) async throws -> MovieEntity?
    func deleteAll() async throws
}
