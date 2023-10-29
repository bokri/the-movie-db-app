//
//  ConsoleDestination.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation
import OSLog

internal class ConsoleDestination: LogDestination {
    internal init() {
    }

    internal func debug(_ message: String) {
        #if DEBUG
        let log = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "TMDB")
        os_log("%{public}@", log: log, type: .debug, message)
        #endif
    }

    internal func warning(_ message: String) {
        #if DEBUG
        let log = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "TMDB")
        os_log("%{public}@", log: log, type: .fault, message)
        #endif
    }

    internal func errorMessage(_ message: String, _ file: String, _ function: String, _ line: Int) {
        #if DEBUG
        let log = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "TMDB")
        os_log("%{public}@", log: log, type: .error, message)
        #endif
    }

    internal func error(_ error: Error, _ file: String, _ function: String, _ line: Int) {
        #if DEBUG
        let log = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "TMDB")
        os_log("%{public}@", log: log, type: .error, error.localizedDescription)
        #endif
    }
}
