//
//  String+Extensions.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation

public extension String {

    /**
     Formats a date string in "yyyy-MM-dd" format into a human-readable string with the format "MMMM yyyy".

     - Returns: A formatted date string in the "MMMM yyyy" format if the input string is a valid date; otherwise, an empty string.

     - Note: This method parses a date string in "yyyy-MM-dd" format and converts it to a more human-friendly "MMMM yyyy" format. If the input string cannot be parsed as a valid date, an empty string is returned.

     - Parameter self: The input date string in "yyyy-MM-dd" format.

     - Returns: A formatted date string in "MMMM yyyy" format if the input string is a valid date; otherwise, an empty string.
     */
    func formatDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "MMMM yyyy"
            return dateFormatter.string(from: date)
        }

        return ""
    }
}
