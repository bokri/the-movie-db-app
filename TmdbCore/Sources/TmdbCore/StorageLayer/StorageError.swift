//
//  StorageError.swift
//
//
//  Created by Aymen Bokri on 14/02/2024.
//

import Foundation

public enum StorageError: Error {
    case dbInitError
    case dbFetchingError
    case dbCreationError
    case dbDeletionError
}
