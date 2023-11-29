//
//  HomeTabView.swift
//  MinimalExpense
//
//  Created by Shiva Raj on 11/9/23.
//

import SwiftUI
import Charts

struct HomeTabView: View {
    
    @Environment (\.managedObjectContext) var managedObjConetxt
    
    private var categorySums: [DataStructs.CategorySum] {
        ExpenseViewModel().sumOfAmountsGroupedByCategory(context: managedObjConetxt)
    }
    
    private var transactionGroupedData: [DataStructs.TransactionTypeGrouped] {
        ExpenseViewModel().calculateTotalAmountAndCountByTransactionType(context: managedObjConetxt)
    }
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Expense.createdOn, ascending: false)],
        animation: .default)
    
    private var expenses: FetchedResults<Expense>
    
    // Create a date formatter to format the date
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM, yyyy"
        return formatter
    }()
    
    var body: some View {
        NavigationView{
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    
                    HStack {
                        Text("Home")
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)
                        
                        Text(dateFormatter.string(from: Date()))
                    }
                    
                    
                    VStack(alignment: .trailing, spacing: 12) {
                        
                        HStack {
                            Text(90000.stringFormat)
                                .font(.largeTitle.bold())
                            Spacer()
                            Button(action: {}) {
                                HStack {
                                    Text("Expand")
                                    Image(systemName: "arrow.up.left.and.arrow.down.right")
                                }
                                .tint(.minimalTheme)
                                .fixedSize(horizontal: true, vertical: false)
                            }
                        }
                        .padding(.bottom)
                        monthlyExpensesChartView()
                    }
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color(.systemGray5))
                    }
                    
                    ExpensesCard(expenses: expenses)
                    
                    TransactionTypeCard(transactionTypeGroupedData: transactionGroupedData, expenses: expenses)
                    
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .background(Color(.systemBackground))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    VStack {
                        Text("Minimal")
                            .font(.title)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                
                ToolbarItem {
                    Image(systemName: "bell.badge")
                        .renderingMode(.original)
                }
            }
        }
    }
    
    @ViewBuilder
    func monthlyExpensesChartView() -> some View {
        
        Chart(categorySums) {category in
            BarMark (
                x: .value("Category", category.category),
                y: .value("Total Expense", category.totalAmount)
            )
        }
        .frame(height: 150)
    }
}

#Preview {
    HomeTabView()
}
