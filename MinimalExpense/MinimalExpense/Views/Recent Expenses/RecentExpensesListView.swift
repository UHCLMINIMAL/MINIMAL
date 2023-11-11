//
//  RecentExpensesListView.swift
//  MinimalExpense
//
//  Created by Shiva Raj on 11/9/23.
//

import SwiftUI

struct RecentExpensesListView: View {
    
    var expenses: FetchedResults<Expense>
    var body: some View {
        ScrollView {
            VStack {
                
                RecentEcpensesView(expenses: expenses, isHomeView: false)
                
                Spacer()
            }
            .navigationBarTitle("Recent Expences", displayMode: .inline)
            .padding()
        }
    }
}
