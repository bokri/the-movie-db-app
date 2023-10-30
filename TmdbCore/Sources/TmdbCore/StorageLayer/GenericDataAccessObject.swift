//
//  GenericDataAccessObject.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation
import SwiftData

/**
 A generic data access object (DAO) for working with persistent model entities.

 This struct, `GenericDataAccessObject`, provides a generic interface for accessing, creating, and saving persistent model entities within a given `ModelContext`. It can be used to interact with the data store and manage data related to a specific model.
 
 # Functionality:
 The `GenericDataAccessObject` struct offers the following functionality:
 - Retrieving all entities of a specific model type from the data store.
 - Creating and inserting new entities of the model type into the data store.
 - Saving changes made to the local data store.

 # Parameters:
 - `Model`: A type that conforms to the `PersistentModel` protocol, representing a model entity with persistent storage properties.
*/
open class GenericDataAccessObject<Model: PersistentModel> {
    
    // MARK: - Properties
    
    /// The context for working with model data within the local data store.
    private let context: ModelContext
    
    // MARK: - Constructors

    /**
     Initializes a `GenericDataAccessObject` with the provided context.
     
     - Parameter context: The `ModelContext` for working with model data within the data store.
     */
    init(context: ModelContext) {
        self.context = context
    }
    
    // MARK: - DAO Methods
    
    /**
     Retrieves all entities of the specified model type from the data store.
     
     - Returns: An array of entities of the model type, retrieved from the data store.
     
     - Throws: An error if there is an issue with retrieving the data from the data store.
     */
    open func getAll() throws -> [Model] {
        let params = FetchDescriptor<Model>()
        let result = try context.fetch(params)
        return result
    }
    
    /**
     Creates and inserts new entities of the model type into the data store.
     
     - Parameter models: An array of model entities to create and insert into the data store.
     */
    open func create(_ models: [Model]) {
        for model in models {
            context.insert(model)
        }
    }

    /**
     Saves changes made to the local data store.
     
     This method checks if there are changes in the data store and saves them if necessary.
     
     - Throws: An error if there is an issue with saving the changes to the data store.
     */
    open func save() throws {
        if context.hasChanges {
            try context.save()
        }
    }
}
