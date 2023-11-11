//
//  TransactionTypeCard.swift
//  MinimalExpense
//
//  Created by Shiva Raj on 11/10/23.
//

import SwiftUI

struct TransactionTypeCard: View {
    
    var transactionTypeGroupedData: [DataStructs.TransactionTypeGrouped]
    var expenses: FetchedResults<Expense>
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Transaction Type Spending")
                .bold()
            
            if !transactionTypeGroupedData.isEmpty {
                ForEach(transactionTypeGroupedData, id: \.id) { transactionType in
                    TransactionTypeGroupedRow(transactionType: transactionType, expenses: expenses)
                    Divider()
                }
            } else {
                Text("No recent expenses.")
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemGray5))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: .gray.opacity(0.5), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y:5)
        
    }
}
