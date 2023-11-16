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
    @Environment (\.managedObjectContext) var managedObjConetxt
    var isHomeView: Bool = true
    @Binding var editMode: EditMode
    var body: some View {
        
        let numberOfRows = isHomeView ? min(3,expenses.count) : expenses.count
        
        if !expenses.isEmpty {
            if isHomeView {
                ForEach(expenses.prefix(numberOfRows)) { expense in
                    TransactionRow(expense: expense)
                        .tag(expense)
                        .onTapGesture {
                            print("Tapped")
                        }
                    
                    Divider()
                }
            } else {
                List {
                    ForEach(expenses.prefix(numberOfRows)) { expense in
                        TransactionRow(expense: expense)
                            .tag(expense)
                            .onTapGesture {
                                print("Tapped")
                            }
                    }
                    .onDelete(perform: deleteExpense)
                }
                .frame(maxWidth: .infinity)
                .navigationBarTitle("Recent Expenses")
                .navigationBarItems(trailing: EditButton())
                .environment(\.editMode, $editMode)
            }
        } else {
            Text("No recent expenses.")
                .foregroundColor(.secondary)
        }
        
    }

    
    private func deleteExpense(offsets: IndexSet) {
        // Delete the expense from Core Data
        withAnimation {
            // Use the managed object context to delete the selected expenses
            offsets.map { expenses[$0] }.forEach { expense in
                ExpenseViewModel().deleteExpense(expense: expense, context: managedObjConetxt)
            }
        }
    }
}
