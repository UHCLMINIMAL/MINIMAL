//
//  ReportView.swift
//  MinimalExpense
//
//  Created by Shiva Raj on 11/16/23.
//

import SwiftUI
import Charts

struct ReportView: View {
    
    @Environment (\.managedObjectContext) var managedObjConetxt
    
    private var categorySums: [DataStructs.CategorySum] {
        ExpenseViewModel().sumOfAmountsGroupedByCategory(context: managedObjConetxt)
    }
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Expense.createdOn, ascending: false)],
        animation: .default)
    
    private var expenses: FetchedResults<Expense>
    @State private var rawSelectedDate: Date? = nil

    // Create a date formatter to format the date
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM, yyyy"
        return formatter
    }()
    
    var body: some View {
        
        let totalSum = categorySums.reduce(0) { $0 + $1.totalAmount }
        
        VStack(alignment: .leading, spacing: 20) {
            
            Text("Analysis")
                .font(.title.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
            
            ScrollView(showsIndicators: false) {
                VStack {
                    VStack(alignment: .leading, spacing: 12) {
                        
                        HStack {
                            Text(dateFormatter.string(from: Date()))
                                .font(.title2)
                            
                            Spacer()
                            
                            Text(totalSum.stringFormat)
                                .font(.title2)
                            
                        }
                        .padding(.bottom)
                        
                        monthlyExpensesChartView()
                    }
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color(.systemGray5))
                    }
                    
                    VStack {
                        Text("Spending By Category")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)
                            .font(.title2)
                        
                        categoryPieChart()
                        
                        expensesListView()
                            .frame(height: 300)
                        
                    }
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color(.systemBackground))
                    }
                    Spacer()
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    func monthlyExpensesChartView() -> some View {
        
        Chart(expenses) { expense in
            
            BarMark(x: .value("Day", expense.expenseDate ?? Date(), unit: .day),
                    y: .value("Amount", expense.amount))
            .foregroundStyle(Color.blue.gradient)
            
            if let rawSelectedDate {
                RuleMark(x: .value("Selected Date", rawSelectedDate, unit: .day))
                    .foregroundStyle(Color.gray.opacity(0.3))
                    .zIndex(-1)
                    .annotation(position: .top,
                                spacing: 0,
                                overflowResolution: .init(x:.fit(to: .chart), y: .disabled)) {
                        Text(rawSelectedDate.formatted())
                    }
            }
        }
        .chartXSelection(value: $rawSelectedDate)
        .frame(height: 150)
    }
    
    @ViewBuilder
    func categoryPieChart() -> some View {
        
        Chart(categorySums) { expense in
            SectorMark(angle: .value("Expense Category", expense.totalAmount),
                       innerRadius: .ratio(0.618),
                       angularInset: 1.5)
            .cornerRadius(5)
            .foregroundStyle(by: .value("Category", expense.category))
        }
        .padding()
        .chartLegend(position: .trailing, alignment: .leadingFirstTextBaseline, spacing: 5)
        .frame(height: 100)
        
    }
    
    
    @ViewBuilder
    func expensesListView() -> some View {
        
        let totalSum = categorySums.reduce(0) { $0 + $1.totalAmount }
        
        List(categorySums.sorted(by: { $0.totalAmount > $1.totalAmount })) { expense in
            HStack {
                RoundedRectangle(cornerRadius: 50, style: .continuous)
                    .frame(width: 30, height: 30)
                    .overlay {
                        Image(expense.category)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    }
                Text(expense.category)
                Spacer()
                Text(expense.totalAmount.stringFormat)
                Text("("+String(format: "%.2f%%",(expense.totalAmount/totalSum)*100)+")")
                    .font(.footnote)
            }
        }
        .padding()
        .listStyle(PlainListStyle())
    }
}

#Preview {
    ReportView()
}
