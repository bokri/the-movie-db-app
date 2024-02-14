//
//  MoviesRepository.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation
import RealmSwift

public actor MoviesRepository: MoviesRepositoryProtocol {
    
    public typealias MediaType = MovieDbModel
    
    public init() {
    }
    
    public func addAndUpdateMedias(_ medias: [MovieItem]) async throws {
        do {
            let realm = try await Realm(actor: self)

            try await realm.asyncWrite {
                realm.add(medias.toData(), update: .modified)
            }
        } catch {
            throw StorageError.dbCreationError
        }
    }
    
    public func addAndUpdateMedia(_ media: MovieDetail) async throws {
        do {
            let realm = try await Realm(actor: self)

            try await realm.asyncWrite {
                realm.add(media.toDetailData(), update: .modified)
            }
        } catch {
            throw StorageError.dbCreationError
        }
    }
    
    public func getMedias() async throws -> [MovieEntity] {
        do {
            let realm = try await Realm(actor: self)

            return Array(realm.objects(MovieDbModel.self)).toEntities()
        } catch {
            throw StorageError.dbFetchingError
        }
    }
    
    public func getMedia(id: Int) async throws -> MovieEntity? {
        do {
            let realm = try await Realm(actor: self)

            return realm.object(ofType: MovieDbModel.self, forPrimaryKey: id)?.toEntity()
        } catch {
            throw StorageError.dbFetchingError
        }
    }

    public func deleteAll() async throws {
        do {
            let realm = try await Realm(actor: self)
            
            try await realm.asyncWrite {
                realm.deleteAll()
            }
        } catch {
            throw StorageError.dbDeletionError
        }
    }
}
