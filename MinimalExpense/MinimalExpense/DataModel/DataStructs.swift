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
    
    struct TransactionTypeGrouped: Identifiable {
        struct TransactionTypeValues {
            var totalAmount: Double
            var count: Int
        }
        var id = UUID()
        var data: [String: TransactionTypeValues]
    }
}
