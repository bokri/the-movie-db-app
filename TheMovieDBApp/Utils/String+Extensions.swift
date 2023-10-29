//
//  String+Extensions.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import Foundation

public extension String {
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
