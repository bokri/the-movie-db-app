//
//  NetworkError.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation

public enum NetworkError: Error {
    case badURL
    case requestFailed
    case invalidData
}
