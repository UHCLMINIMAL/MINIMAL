//
//  NewHomeSiftUIView.swift
//  MINIMAL
//
//  Created by Shiva Raj on 11/5/23.
//

import SwiftUI
import Charts

struct NewHomeSiftUIView: View {
    
    private let categorySums = ExpenseDataManadger.fetchCategorySum()
    
    struct PieChartDataEntry: Identifiable {
        var id: Int
        
        var value: Double
        var label: String
    }
    
    var dataEntries: [PieChartDataEntry] = [
        PieChartDataEntry(id: 1, value: 8, label: "Housing"),
        PieChartDataEntry(id: 2, value: 2, label: "Food"),
        PieChartDataEntry(id: 3, value: 4, label: "Misc"),
        PieChartDataEntry(id: 4, value: 6, label: "LifeStyle"),
        PieChartDataEntry(id: 5, value: 12, label: "Travel"),
        PieChartDataEntry(id: 5, value: 14, label: "Health")
    ]
    
    
    
    var body: some View {
        NavigationView{
            ScrollView{
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    Text("Home")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .padding(.leading)
                    
                    VStack(alignment: .trailing, spacing: 12) {
                        
                        HStack {
                            Text(90000.stringFormat)
                                .font(.largeTitle.bold())
                            Spacer()
                            Button(action: {}) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10) // Adjust the cornerRadius as needed
                                        .foregroundColor(Color.minimalTheme) // Set your desired background color
                                    HStack {
                                        Image(systemName: "chart.bar.xaxis.ascending")
                                        Text("Explore")
                                    }
                                    .padding(8)
                                    .foregroundColor(.white) // Set the text color
                                }
                                .padding([.leading])
                                .fixedSize(horizontal: true, vertical: false)
                            }
                        }
                        .padding(.bottom)
                        currentMonthChart()
                    }
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color(.systemGray5))
                    }
                    
                    RecentEcpensesView()
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
    func currentMonthChart() -> some View {
        
        Chart(categorySums) {category in
            BarMark (
                x: .value("Category", category.category),
                y: .value("Total Expense", category.sum)
            )
        }
        .frame(height: 200)
    }
}


#Preview {
    NewHomeSiftUIView()
}

extension Double {
    var stringFormat: String {
        if self >= 10000 && self <= 999999 {
            return String(format: "$%.1fk", self/1000).replacingOccurrences(of: ".0", with: "")
        }
        if self > 999999 {
            return String(format: "$%.1fM", self/1000000).replacingOccurrences(of: ".0", with: "")
        }
        return String(format: "$%.0f", self)
    }
}
