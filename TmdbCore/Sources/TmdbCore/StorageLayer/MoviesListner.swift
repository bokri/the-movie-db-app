//
//  MoviesListner.swift
//
//
//  Created by Aymen Bokri on 14/02/2024.
//

import Foundation
import SwiftUI
import RealmSwift

@propertyWrapper public struct MoviesListner: DynamicProperty {
    // MARK: - Properties

    ///
    /// This variable is a Realm observed result
    /// A property wrapper type that represents the results of a query on a realm.
    @ObservedResults(MovieDbModel.self,
                     sortDescriptor: SortDescriptor(keyPath: \MovieDbModel.popularity, ascending: false)) var results

    // MARK: - Constructors

    public init() {}

    // MARK: - Property Wrapper mandatory variables

    ///
    /// This variable returns the inner value of the property wrapper
    /// In our case it returns the converted Entity of the database result
    public var wrappedValue: [MovieEntity] {
        Array(results).toEntities()
    }
}
