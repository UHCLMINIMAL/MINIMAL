//
//  Extensions.swift
//  MinimalExpense
//
//  Created by Shiva Raj on 11/9/23.
//

import Foundation


extension Double {
    var stringFormat: String {
        if self >= 1000 && self <= 999999 {
            return String(format: "$%.1fk", self/1000).replacingOccurrences(of: ".0", with: "")
        }
        if self > 999999 {
            return String(format: "$%.1fM", self/1000000).replacingOccurrences(of: ".0", with: "")
        }
        return String(format: "$%.0f", self)
    }
}

extension DateFormatter {
    static let month: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter
    }()
}

extension String {
    func convertMonthStringToYearMonthInt() -> Int32? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM, yyyy" // Set the input format based on your current format
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "yyyyMM" // Set the desired output format
            return Int32(dateFormatter.string(from: date))
        }
        return nil // Handle invalid input string or conversion failure
    }
}
