//
//  AddExpenseView.swift
//  MinimalExpense
//
//  Created by Shiva Raj on 11/8/23.
//

import SwiftUI

struct AddExpenseView: View {
    
    @Environment (\.managedObjectContext) var managedObjConetxt
    @Environment (\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var selectedtransactionTypeIndex = 1
    @State private var selectedtransactionType = "Card"
    @State private var amount = "0"
    @State private var category = "LifeStyle"
    @State private var selectedCategoryIndex = 0
    @State private var selectedfrequencyIndex = 0
    @State private var selectedfrequency = ""
    @State private var expenseDate = Date()
    var isEditMode: Bool = false
    
    let frequencies = ["Never", "Daily", "Weekly", "Monthly", "Quarterly", "Yearly"]
    let transactionTypes = ["Cash", "Card"]
    let categoryMapping: [String: String] = [
           "Groceries": "cart.circle",
           "LifeStyle": "heart.circle",
           "Travel": "car.circle",
           "Medical": "cross.case.circle",
           "Food": "fork.knife.circle",
           "miscellaneous": "gearshape",
       ]
    
    var expense: Expense?
    
    init(expense: Expense? = nil) {
        
        self.expense = expense
        
        // Customizations for the UISegmentedControl
        UISegmentedControl.appearance().backgroundColor = .minimalTheme.withAlphaComponent(0.15)
        UISegmentedControl.appearance().setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        UISegmentedControl.appearance().selectedSegmentTintColor = .minimalTheme
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        
        // Set initial values if editing existing expense
        if let expense = expense {
            isEditMode = true
            _title = State(initialValue: expense.title ?? "")
            _selectedtransactionTypeIndex = State(initialValue: transactionTypes.firstIndex(of: expense.transactionType ?? "Card") ?? 1)
            _selectedtransactionType = State(initialValue: expense.transactionType ?? "Card")
            _amount = State(initialValue: "\(expense.amount)")
            _category = State(initialValue: expense.category ?? "")
            _selectedfrequencyIndex = State(initialValue: frequencies.firstIndex(of: expense.frequency ?? "Never") ?? 0)
            _selectedfrequency = State(initialValue: expense.frequency ?? "Never")
            _expenseDate = State(initialValue: expense.expenseDate ?? Date())
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text("Add Expense")
                    .font(.title)
                Spacer()
                Button(action: {
                    self.dismiss()
                }, label: {
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(.minimalTheme)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                })
            }
            .padding()
        }
        
        Section {
            VStack {
                HStack {
                    Text("$")
                    TextField("Enter Amount", text: $amount)
                }
                .padding()
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                
                Picker("Transaction Type", selection: $selectedtransactionTypeIndex) {
                    ForEach(transactionTypes.indices, id: \.self) { index in
                        Text(transactionTypes[index]).tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .onChange(of: selectedtransactionTypeIndex, {
                    selectedtransactionType = transactionTypes[selectedtransactionTypeIndex]
                })
                .accentColor(.red)
                .padding()
            }
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .frame(height: 150)
        .background(Color(.systemGray5))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: .gray.opacity(0.2), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y:5)
        .padding()
        
        Section {
            VStack(alignment: .center) {
                HStack {
                    Text("Title")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    TextField("Expense Name", text: $title)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .multilineTextAlignment(.trailing)
                }
                .padding(10)
                
                Divider()
                
                HStack {
                    Text("Category")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    Picker(selection: $category, label: Text("")) {
                        ForEach(categoryMapping.keys.sorted(), id: \.self) { category in
                            HStack {
                                Image(systemName: categoryMapping[category] ?? "questionmark.circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                Text(category)
                                    .tag(category)
                            }
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .tint(.black)
                }
                .padding(10)
                
                Divider()
                
                HStack {
                    Text("Expense Date")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    
                    DatePicker("", selection: $expenseDate, displayedComponents: .date)
                                    .datePickerStyle(.compact)
                                    .tint(.minimalTheme)
                }
                .padding(10)
                
                Divider()
                
                HStack {
                    Text("Repeat")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    
                    Picker("", selection: $selectedfrequencyIndex) {
                        ForEach(frequencies.indices, id: \.self) { index in
                            Text(frequencies[index]).tag(index)
                        }
                    }
                    .onChange(of: selectedfrequencyIndex, {
                        selectedfrequency = frequencies[selectedfrequencyIndex]
                    })
                    .tint(.black)
                    
                }
                .padding(10)
             
                Spacer()
                
                Button(action: {
                    if !isEditMode {
                        ExpenseViewModel().addExpense(title: title, transactionType: selectedtransactionType, amount: Double(amount) ?? 0, category: category, expenseDate: expenseDate, frequency: selectedtransactionType ,context: managedObjConetxt)
                    } else {
                        ExpenseViewModel().editExpense(expense: expense ?? Expense(), title: title, transactionType: selectedtransactionType, amount: Double(amount) ?? 0, category: category, expenseDate: expenseDate, frequency: selectedtransactionType ,context: managedObjConetxt)
                    }
                    self.dismiss()
                }, label: {
                    Text(!isEditMode ? "Add Expense" : "Edit Expense")
                })
                .padding([.top, .bottom], 10)
                .padding([.leading, .trailing], 90)
                .tint(.white)
                .background(Color(.minimalTheme))
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(color: .gray.opacity(0.2), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y:5)
                .padding()
            }
            .padding(10)
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .background(Color(.systemGray5))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: .gray.opacity(0.2), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y:5)
        .padding()
    }
}

#Preview {
    AddExpenseView()
}
