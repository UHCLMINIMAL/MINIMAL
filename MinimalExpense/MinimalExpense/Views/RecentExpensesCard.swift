//
//  RecentExpensesCard.swift
//  MinimalExpense
//
//  Created by Shiva Raj on 11/9/23.
//

import SwiftUI

struct RecentExpensesCard: View {
    
    var body: some View {
        VStack {
            HStack{
                Text("Recent Expenses")
                    .bold()
                
                Spacer()
                
                NavigationLink(destination: RecentExpensesListView()) {
                    HStack(spacing: 4) {
                        Text("See All")
                            .font(.headline)
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.blue)
                }
            }
            .padding(.top)
            
            RecentEcpensesView(isHomeView: true)
        }
        .padding()
        .background(Color(.systemGray5))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: .gray.opacity(0.5), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y:5)
    }
}

#Preview {
    RecentExpensesCard()
}
