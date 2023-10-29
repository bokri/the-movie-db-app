//
//  Logger.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation
import os.log

open class Logger {
    private static var destinations: [LogDestination] = [ConsoleDestination()]

    private enum Level {
        case debug
        case warning
        case error

        var levelColor: String {
            #if DEBUG
            switch self {
            case .debug:
                return "🔵"
            case .warning:
                return "🔶"
            case .error:
                return "🔴"
            }
            #else
            return ""
            #endif
        }
    }

    open class func addDestination(_ destination: LogDestination) {
        if Logger.destinations.contains(where: { (lhs) -> Bool in
            String(describing: destination) == String(describing: lhs)
        }) {
            return
        }

        Logger.destinations.append(destination)
    }

    // MARK: Levels

    /// log something which help during debugging (low priority)
    open class func debug(_ message: String,
                          _ file: String = #fileID,
                          _ function: String = #function,
                          _ line: Int = #line) {
        let formattedString = Logger.formatString(level: .debug,
                                                  message: message,
                                                  file: file,
                                                  function: function,
                                                  line: line)

        for destination in Logger.destinations {
            destination.debug(formattedString)
        }
    }

    /// log something which may cause big trouble soon (high priority)
    open class func warning(_ message: String,
                            _ file: String = #fileID,
                            _ function: String = #function,
                            _ line: Int = #line) {
        let formattedString = Logger.formatString(level: .warning,
                                                  message: message,
                                                  file: file,
                                                  function: function,
                                                  line: line)

        for destination in Logger.destinations {
            destination.warning(formattedString)
        }
    }

    /// log something which will keep you awake at night (highest priority)
    open class func error(_ error: Error,
                          _ file: String = #fileID,
                          _ function: String = #function,
                          _ line: Int = #line) {
        for destination in Logger.destinations {
            destination.error(error, file, function, line)
        }
    }

    open class func error(_ errorMessage: String,
                          _ file: String = #fileID,
                          _ function: String = #function,
                          _ line: Int = #line) {
        let formattedString = Logger.formatString(level: .error,
                                                  message: errorMessage,
                                                  file: file,
                                                  function: function,
                                                  line: line)
        for destination in Logger.destinations {
            destination.errorMessage(formattedString, file, function, line)
        }
    }

    /// Format log parameters into a readable String
    private class func formatString(level: Logger.Level,
                                    message: String,
                                    file: String,
                                    function: String,
                                    line: Int) -> String {
        let fileName = ((file as NSString).lastPathComponent as NSString).deletingPathExtension
        let moduleName = (file as NSString).pathComponents.first ?? ""

        return "\(level.levelColor) [\(moduleName)] \(message) => \(fileName).\(function):\(line)".trimmingCharacters(in: .whitespaces)
    }
}
