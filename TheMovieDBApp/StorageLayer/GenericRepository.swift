//
//  GenericRepository.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation
import SwiftData

struct GenericRepository<Model: PersistentModel> {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }
    
    func getAll() throws -> [Model] {
        let params = FetchDescriptor<Model>()
        let result = try context.fetch(params)
        return result
    }
    
    func create(_ models: [Model]) {
        for model in models {
            context.insert(model)
        }
    }

    /// Save changes made to the local data store
    func save() throws {
        if context.hasChanges {
            try context.save()
        }
    }
}
