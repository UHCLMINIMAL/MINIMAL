//
//  Utils.swift
//  MINIMAL
//
//  Created by Shiva Raj on 10/14/23.
//

import Foundation

class Utils {
    
    func formattedDate(_ date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format // Customize the date format as needed
        return dateFormatter.string(from: date)
    }
    
}
