//
//  BudgetViewModel.swift
//  MinimalExpense
//
//  Created by Shiva Raj on 12/2/23.
//

import Foundation
import CoreData

class BudgetViewModel: ObservableObject {
    
    func getMonthYearListFromCurrentDate() -> [String] {
        let currentDate = Date()
        let calendar = Calendar.current

        // Get the current month and year components
        let currentMonth = calendar.component(.month, from: currentDate)
        let currentYear = calendar.component(.year, from: currentDate)

        // Create a date formatter to get the month names
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current

        // Create an array to store the month and year names
        var monthYearList: [String] = []

        // Loop through the months of the current year starting from the current month
        for month in currentMonth...12 {
            // Set the date components to the first day of each month
            var dateComponents = DateComponents()
            dateComponents.year = currentYear
            dateComponents.month = month
            dateComponents.day = 1

            // Create a date object for the first day of the current month
            if let firstDayOfMonth = calendar.date(from: dateComponents) {
                // Use the date formatter to get the month and year names
                let monthName = dateFormatter.monthSymbols[calendar.component(.month, from: firstDayOfMonth) - 1]
                let yearName = "\(currentYear)"

                // Combine month and year names and add to the array
                let monthYearString = "\(monthName), \(yearName)"
                monthYearList.append(monthYearString)
            }
        }
        return monthYearList
    }
}
