//
//  RecentEcpensesView.swift
//  MINIMAL
//
//  Created by Shiva Raj on 11/6/23.
//

import SwiftUI
import CoreData

struct RecentEcpensesView: View {
    
    var expenses: FetchedResults<Expense>
    var isHomeView: Bool = true
    var body: some View {
        
        let numberOfRows = isHomeView ? min(3,expenses.count) : expenses.count
        
        if !expenses.isEmpty {
            ForEach(expenses.prefix(numberOfRows)) { expense in
                TransactionRow(expense: expense)
                Divider()
            }
        } else {
            Text("No recent expenses.")
                .foregroundColor(.secondary)
        }
    }
}
