//
//  RecentExpensesListView.swift
//  MinimalExpense
//
//  Created by Shiva Raj on 11/9/23.
//

import SwiftUI

struct RecentExpensesListView: View {
    var body: some View {
        VStack {
            
            RecentEcpensesView(isHomeView: false)
            
            Spacer()
        }
        .navigationBarTitle("Recent Expences", displayMode: .inline)
        .padding()
    }
}

#Preview {
    RecentExpensesListView()
}
