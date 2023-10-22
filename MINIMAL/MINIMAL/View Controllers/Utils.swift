//
//  Utils.swift
//  MINIMAL
//
//  Created by Shiva Raj on 10/14/23.
//

import Foundation

class Utils {
    
    func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy" // Customize the date format as needed
        return dateFormatter.string(from: date)
    }
    
}
