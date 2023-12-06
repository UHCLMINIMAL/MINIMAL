//
//  MonthYearPickerSheet.swift
//  MinimalExpense
//
//  Created by Shiva Raj on 11/30/23.
//

import SwiftUI

struct MonthYearPickerSheet: View {
    @Binding var selectedDate: Date

    var body: some View {
        VStack {
            DatePicker(
                "",
                selection: $selectedDate,
                in: ...getEndOfMonth(), displayedComponents: [.date]
            )
            .datePickerStyle(WheelDatePickerStyle())
            .labelsHidden()

            Button("Done") {
                // Add your logic here to save the selected date or perform any other actions
            }
        }
        .padding()
    }

    func getEndOfMonth() -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: selectedDate)
        guard let startOfMonth = calendar.date(from: components),
              let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)
        else {
            return Date()
        }
        return endOfMonth
    }
}
