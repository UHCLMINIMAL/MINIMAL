//
//  File.swift
//  MinimalExpense
//
//  Created by Shiva Raj on 11/9/23.
//

import Foundation

class DataStructs {
    struct CategorySum: Identifiable {
        var id = UUID()
        var category: String
        var totalAmount: Double
    }
    
    struct AmountByDate: Identifiable {
        var id = UUID()
        var expenseDate: Date
        var totalAmount: Double
        
        var formattedDate: String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: expenseDate)
        }
    }
    
    struct TransactionTypeGrouped: Identifiable {
        struct TransactionTypeValues {
            var totalAmount: Double
            var count: Int
        }
        var id = UUID()
        var data: [String: TransactionTypeValues]
    }
}
