//
//  BudgetViewModel.swift
//  MinimalExpense
//
//  Created by Shiva Raj on 12/2/23.
//

import Foundation
import CoreData

class BudgetViewModel: ObservableObject { 
    
    let container = NSPersistentContainer(name: "MinimalExpense")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Budget Saved")
        } catch {
            print("Data Saved Failed")
        }  
    }
    
    func addBudget(budgetAmount: Double, budgetPeriod: Int32, createdOn: Date, context: NSManagedObjectContext) {
        
        let newBudget = Budget(context: context)
        
        newBudget.budgetID = UUID()
        newBudget.budgetAmount = budgetAmount
        newBudget.budgetPeriod = budgetPeriod
        newBudget.createdOn = Date()
        
        save(context: context)
        print("Saved")
    }
    
    func editBudget (budget: Budget, budgetAmount: Double, budgetPeriod: Int32, createdOn: Date, context: NSManagedObjectContext) {
        
        budget.budgetAmount = budgetAmount
        budget.budgetPeriod = budgetPeriod
        budget.createdOn = Date()
        
        save(context: context)
    }
    
    // get Budget Amount for the selected Month
    func retriveBudget(budgetPeriod: Int32, context: NSManagedObjectContext) -> Double {
        
        let fetchRequest = NSFetchRequest<Budget>(entityName: "Budget")
        
        // Create a predicate to filter budget for the selected month
        print(budgetPeriod)
        let predicate = NSPredicate(format: "budgetPeriod = %ld", budgetPeriod as CVarArg)
        fetchRequest.predicate = predicate
        
        do {
            let results = try context.fetch(fetchRequest)
            
            if let budget = results.first {
                let budgetAmount = budget.budgetAmount
                return budgetAmount
            } else {
                return 0
            }
        } catch {
            print("Error fetching Budget: \(error)")
            return 0
        }
    }
    
    func deleteBudget(budget: Budget, context: NSManagedObjectContext) {
        context.delete(budget)
        do {
            try context.save()
            print("Budget Deleted")
        } catch {
            print("Data Deleted Failed")
        }
    }
    
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
