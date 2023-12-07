//
//  RecentExpensesCard.swift
//  MinimalExpense
//
//  Created by Shiva Raj on 11/9/23.
//

import SwiftUI

struct ExpensesCard: View {
    
    @Environment(\.managedObjectContext) var managedObjConetxt
    
    var expenses: FetchedResults<Expense>
    
    @State private var editMode = EditMode.inactive
    
    var body: some View {
        VStack {
            HStack{
                Text("Recent Expenses")
                    .bold()
                
                Spacer()
                
                NavigationLink(destination: RecentEcpensesView(isHomeView: false, editMode: $editMode)) {
                    HStack(spacing: 4) {
                        Text("See All")
                            .font(.headline)
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.blue)
                }
            }
            
            RecentEcpensesView(isHomeView: true, editMode: .constant(.inactive))
        }
        .padding()
        .background(Color(.systemGray5))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: .gray.opacity(0.5), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y:5)
    }
}
