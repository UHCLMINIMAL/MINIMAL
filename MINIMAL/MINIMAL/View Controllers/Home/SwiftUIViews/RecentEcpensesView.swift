//
//  RecentEcpensesView.swift
//  MINIMAL
//
//  Created by Shiva Raj on 11/6/23.
//

import SwiftUI
import CoreData

struct RecentEcpensesView: View {
    
    var expenses =  ExpenseDataManadger.fetchAllExpenses()
    
    var body: some View {
        VStack {
            HStack{
                Text("Recent Expenses")
                    .bold()
                
                Spacer()
                
                NavigationLink {
                    
                } label: {
                    HStack(spacing: 4) {
                        Text("See All")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                }
            }
            .padding(.top)
            
            ForEach(expenses.prefix(3)) { expense in
                TransactionRow(expense: expense)
                Divider()
            }
        }
        .padding()
        .background(Color(.systemGray5))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: .gray.opacity(0.5), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y:5)
    }
}

#Preview {
    RecentEcpensesView()
}
