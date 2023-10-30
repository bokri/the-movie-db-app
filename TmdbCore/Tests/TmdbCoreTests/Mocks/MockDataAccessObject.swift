//
//  File.swift
//  
//
//  Created by Aymen Bokri on 30/10/2023.
//

import Foundation
@testable import TmdbCore
import SwiftData

class MockDataAccessObject<Model: PersistentModel>: GenericDataAccessObject<Model> {
    
    var getAllReturnValue: [Model] = []
    var createCalled = false
    var saveCalled = false

    override func getAll() throws -> [Model] {
        return getAllReturnValue
    }
    
    override func create(_ models: [Model]) {
        createCalled = true
    }
    
    override func save() throws {
        saveCalled = true
    }
}
