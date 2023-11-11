//
//  TransactionRow.swift
//  MINIMAL
//
//  Created by Shiva Raj on 11/6/23.
//

import SwiftUI

struct TransactionRow: View {
    
    var expense: Expense
    
    var body: some View {
        HStack(spacing: 20) {
            
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .frame(width: 45, height: 45)
                .overlay {
                    Image(expense.category ?? "")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 45)
                }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(expense.title ?? "Expense")
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                
                Text(expense.transactionType ?? "Card")
                    .font(.footnote)
                    .lineLimit(1)
                    .opacity(0.7)
                Text(expense.expenseDate ?? Date(), format: .dateTime.year().month().day())
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text(expense.amount, format: .currency(code: "USD"))
        }
        .padding([.top, .bottom], 8)
    }
}
