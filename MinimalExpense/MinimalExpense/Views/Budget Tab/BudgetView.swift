//
//  BudgetView.swift
//  MinimalExpense
//
//  Created by Shiva Raj on 11/29/23.
//

import SwiftUI

struct BudgetView: View {
    
    @Environment (\.managedObjectContext) var managedObjConetxt
    @Environment (\.dismiss) var dismiss
    
    private var categorySums: [DataStructs.CategorySum] {
        ExpenseViewModel().sumOfAmountsGroupedByCategory(context: managedObjConetxt)
    }
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Expense.createdOn, ascending: false)],
        animation: .default)
    
    private var expenses: FetchedResults<Expense>
    
    @State private var budgetAmount: Double = 0.0
    @State private var amount = ""
    @State private var selectedMonth = ""
    @State private var selectedMonthIndex = 0
    @State private var isDatePickerVisible = false
    @State private var isSaveDisbaled = true
    @State private var userDidChangeAmount = false
    @State private var progress = 0.0
    
    let months = BudgetViewModel().getMonthYearListFromCurrentDate()

    var body: some View {
        
        let totalSum = categorySums.reduce(0) { $0 + $1.totalAmount }
        
        ZStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("Budget Manager")
                    .font(.title.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                
                Section {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Budget Amount")
                            .padding([.top ,.leading])
                            .font(.title2)
                            .multilineTextAlignment(.leading)
                        
                        VStack {
                            HStack {
                                Text("$")
                                TextField("Enter Budget Amount", text: $amount)
                                    .bold()
                                    .foregroundColor(Color(.minimalTheme))
                                    .onAppear {
                                        let budgetAmt = BudgetViewModel().retriveBudget(budgetPeriod: Int32("December, 2023".convertMonthStringToYearMonthInt() ?? 199901), context: managedObjConetxt)
                                        amount = String(budgetAmt)
                                        budgetAmount = budgetAmt
                                    }
                                    .onChange(of: amount) {
                                        // Perform actions when the TextField value changes
                                        isSaveDisbaled = !userDidChangeAmount
                                    }
                                    .onTapGesture {
                                        // Set userDidChangeAmount to true when the user taps on the TextField
                                        userDidChangeAmount = true
                                    }
                            }
                            .padding()
                            .font(.title2)
                            
                            Button(action: {
                                if userDidChangeAmount {
                                    
                                } else {
                                    BudgetViewModel().addBudget(
                                        budgetAmount: Double(amount) ?? 0.0,
                                        budgetPeriod: selectedMonth.convertMonthStringToYearMonthInt() ?? 202312,
                                        createdOn: Date(),
                                        context: managedObjConetxt)
                                }
                            }, label: {
                                Text("Save")
                                    .font(.callout)
                            })
                            .disabled(isSaveDisbaled)
                            .padding([.top, .bottom], 5)
                            .padding([.leading, .trailing], 90)
                            .tint(.white)
                            .background(isSaveDisbaled ? Color.gray : Color.minimalTheme)
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                            .shadow(color: .gray.opacity(0.2), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y:5)
                            .padding()
                            .padding()
                        }
                    }
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .background(Color(.systemGray5))
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(color: .gray.opacity(0.2), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y:5)
                    
                Section {
                    HStack {
                        Button(action: {
                            self.selectedMonthIndex = (self.selectedMonthIndex - 1 + self.months.count) % self.months.count
                        }) {
                            Image(systemName: "arrow.left")
                                .foregroundColor(.blue)
                        }

                        Picker(selection: $selectedMonthIndex, label: Text("")) {
                            ForEach(0..<months.count, id: \.self) { index in
                                Text(months[index]).tag(index)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .onChange(of: selectedMonthIndex, {
                            budgetAmount = BudgetViewModel().retriveBudget(budgetPeriod: selectedMonth.convertMonthStringToYearMonthInt() ?? 199901, context: managedObjConetxt)
                        })

                        Button(action: {
                            self.selectedMonthIndex = (self.selectedMonthIndex + 1) % self.months.count
                        }) {
                            Image(systemName: "arrow.right")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding()
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .frame(height: 50)
                .background(Color(.systemGray5))
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(color: .gray.opacity(0.2), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y:5)
                
                VStack {
                    Text("Remaining Budget")
                        .padding(.top)
                        .font(.title2)
                        .multilineTextAlignment(.leading)
                    
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 10.0)
                            .opacity(0.3)
                            .foregroundColor(Color.minimalTheme)

                        Circle()
                            .trim(from: 0.0, to: progress)
                            .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                            .foregroundColor(Color.minimalTheme)
                            .rotationEffect(Angle(degrees: 270.0))
                        
                        VStack{
                            Text((budgetAmount - totalSum).stringFormat)
                                .font(.title)
                                .foregroundColor(progress > 0.85 ? Color.red : Color.minimalTheme)
                            Text("Left to Spend")
                                .font(.caption)
                                .foregroundColor(progress > 0.85 ? Color.red : Color.minimalTheme)
                        }
                        .onAppear {
                            progress = Double(totalSum/budgetAmount)
                            print(totalSum, budgetAmount)
                            print(progress)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(width: 200, height: 200)
                }
                .frame(maxWidth: .infinity)
                
                Spacer()

            }
            .padding()
            .frame(maxWidth: .infinity)
        }
    }
    
    func getFormattedMonth() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: Date())
    }
}


#Preview {
    BudgetView()
}
