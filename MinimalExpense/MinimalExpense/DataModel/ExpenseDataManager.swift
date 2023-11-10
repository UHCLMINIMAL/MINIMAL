//
//  ExpenseDataManager.swift
//  MinimalExpense
//
//  Created by Shiva Raj on 11/8/23.
//

import Foundation
import CoreData

class ExpenseDataManager: ObservableObject {
    
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
            print("Expense Saved")
        } catch {
            print("Data Saved Failed")
        }
        
    }
    
    func addExpense(title: String, transactionType: String, amount: Double, category: String, expenseDate: Date, frequency: String, context: NSManagedObjectContext) {
        
        let newExpense = Expense(context: context)
        newExpense.expenseID = UUID()
        newExpense.title = title
        newExpense.transactionType = transactionType
        newExpense.amount = amount
        newExpense.category = category
        newExpense.expenseDate = expenseDate
        newExpense.frequency = frequency
        newExpense.updatedOn = Date()
        newExpense.createdOn = Date()
        
        save(context: context)
    }
    
    func editExpense(expense: Expense, title: String, transactionType: String, amount: Double, category: String, expenseDate: Date, context: NSManagedObjectContext) {
        
        expense.title = title
        expense.amount = amount
        expense.category = category
        expense.expenseDate = expenseDate
        expense.transactionType = transactionType
        expense.updatedOn = Date()
        
        save(context: context)
    }
    
    func sumOfAmountsGroupedByCategory(context: NSManagedObjectContext) -> [DataStructs.CategorySum] {
        
        let fetchRequest = NSFetchRequest<NSDictionary>(entityName: "Expense")
        fetchRequest.propertiesToFetch = ["category", "amount"]
        fetchRequest.resultType = .dictionaryResultType

        do {
            let results = try context.fetch(fetchRequest)
            var categorySum = [DataStructs.CategorySum]()

            for result in results {
                if let category = result["category"] as? String, let amount = result["amount"] as? Double {
                    categorySum.append(DataStructs.CategorySum(category: category, totalAmount: amount))
                }
            }

            return categorySum
        } catch {
            print("Error fetching category sums: \(error)")
        }
        
        return []
    }
        
}
