//
//  TransactionTypeGroupedRow.swift
//  MinimalExpense
//
//  Created by Shiva Raj on 11/11/23.
//

import SwiftUI

struct TransactionTypeGroupedRow: View {
    
    var transactionType: DataStructs.TransactionTypeGrouped
    var expenses: FetchedResults<Expense>
    
    var body: some View {
        HStack(spacing: 20) {
            
            Image(systemName: transactionType.data.keys.first == "Card" ? "creditcard.circle" : "dollarsign.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 35, height: 35)
                .foregroundColor(.minimalTheme)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(transactionType.data.keys.first ?? "Unknown Type")
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                    .foregroundColor(transactionType.data.keys.first == "Card" ? Color(.minimalTheme) : Color(.systemGreen))
                
                Text("\(transactionType.data.values.first?.count ?? 0) transactions")
                    .font(.footnote)
                    .lineLimit(1)
                    .opacity(0.7)
            }
            
            Spacer()
            
            Text("\(transactionType.data.values.first?.totalAmount ?? 0, format: .currency(code: "USD"))")
        }
        .padding([.top, .bottom], 8)
    }
}
