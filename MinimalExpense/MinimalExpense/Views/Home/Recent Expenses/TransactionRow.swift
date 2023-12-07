//
//  TransactionRow.swift
//  MINIMAL
//
//  Created by Shiva Raj on 11/6/23.
//

import SwiftUI

struct TransactionRow: View {
    
    @Environment(\.managedObjectContext) var managedObjConetxt
    var expenses: FetchedResults<Expense>
    var expense: Expense
    
    let categoryImageMapping: [String: String] = [
           "Groceries": "cart.circle",
           "LifeStyle": "heart.circle",
           "Travel": "car.circle",
           "Medical": "cross.case.circle",
           "Food": "fork.knife.circle",
           "miscellaneous": "gearshape",
       ]
    
    var body: some View {
        HStack(spacing: 20) {
            
            Image(systemName:  categoryImageMapping[expense.category ?? "questionmark.circle"] ?? "questionmark.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 35, height: 35)
                .foregroundColor(.minimalTheme)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(expense.title ?? "Expense")
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                
                Text(expense.transactionType ?? "Card")
                    .font(.footnote)
                    .foregroundColor(expense.transactionType == "Card" ? Color(.minimalTheme) : Color(.systemGreen))
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
