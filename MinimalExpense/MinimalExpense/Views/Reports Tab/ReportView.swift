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
        VStack(alignment: .leading, spacing: 20) {
            
            Text("Analysis")
                .font(.title.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
            
            VStack(alignment: .leading, spacing: 12) {
                
                HStack {
                    Text(dateFormatter.string(from: Date()))
                        .font(.title2)
                    
                    Spacer()
                    
                    Text(90000.stringFormat)
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
            
            categoryPieChart()
            
            Spacer()
            
            
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
    
    func extractDate(from dateTime: Date) -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: dateTime)
        
        if let extractedDate = calendar.date(from: components) {
            return extractedDate
        } else {
            // Handle the case where extraction fails, e.g., return the original date
            return dateTime
        }
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
        .frame(height: 150)
        
    }
        
}



#Preview {
    ReportView()
}
