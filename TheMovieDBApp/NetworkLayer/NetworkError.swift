//
//  NetworkError.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation

/**
 An enumeration defining common network-related errors.

 The `NetworkError` enum provides a set of common network-related errors that can occur during network operations. It is used to represent specific error conditions when working with network requests and responses.

 - Note: This enum is typically used in conjunction with network operations to handle and propagate errors when issues arise during data retrieval or transmission.
*/
public enum NetworkError: Error {
    case badURL
    case requestFailed
    case invalidData
}
