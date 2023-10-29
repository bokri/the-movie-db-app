//
//  LogDestination.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation

public protocol LogDestination: AnyObject {
    func debug(_ message: String)
    func warning(_ message: String)
    func error(_ error: Error, _ file: String, _ function: String, _ line: Int)
    func errorMessage(_ message: String, _ file: String, _ function: String, _ line: Int)
}
