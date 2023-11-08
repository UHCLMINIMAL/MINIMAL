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
    @State private var amount = ""
    @State private var category = ""
    @State private var selectedfrequencyIndex = 0
    @State private var expenseDate = Date()
    
    init() {
        // Customizations for the UISegmentedControl
        UISegmentedControl.appearance().backgroundColor = .minimalTheme.withAlphaComponent(0.15)
        UISegmentedControl.appearance().setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        UISegmentedControl.appearance().selectedSegmentTintColor = .minimalTheme
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text("Add Expense")
                    .font(.title)
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
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
                    Text("Cash").tag(0)
                    Text("Card").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
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
                    TextField("Enter your Category", text: $category)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .multilineTextAlignment(.trailing)
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
                        Text("Never").tag(0)
                        Text("Daily").tag(1)
                        Text("Weekly").tag(2)
                        Text("Monthly").tag(3)
                        Text("Quaterly").tag(4)
                        Text("Yearly").tag(5)
                    }
                    .tint(.black)
                    
                }
                .padding(10)
             
                Spacer()
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Add Expense")
                })
                .padding([.top, .bottom], 10)
                .padding([.leading, .trailing], 90)
                .tint(.white)
                .background(Color(.minimalTheme))
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(color: .gray.opacity(0.2), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y:5)
                .padding()
            }
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
