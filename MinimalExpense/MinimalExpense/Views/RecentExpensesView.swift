//
//  RecentEcpensesView.swift
//  MINIMAL
//
//  Created by Shiva Raj on 11/6/23.
//

import SwiftUI
import CoreData

struct RecentEcpensesView: View {
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Expense.createdOn, ascending: false)],
        animation: .default)
    private var expenses: FetchedResults<Expense>
    
    var isHomeView: Bool = true
    
    var body: some View {
        
        let numberOfRows = isHomeView ? min(3,expenses.count) : expenses.count
        ForEach(expenses.prefix(numberOfRows)) { expense in
            TransactionRow(expense: expense)
            Divider()
        }
    }
}

#Preview {
    RecentEcpensesView()
}
