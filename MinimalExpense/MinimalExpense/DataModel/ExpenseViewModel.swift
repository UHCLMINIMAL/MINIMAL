//
//  ExpenseDataManager.swift
//  MinimalExpense
//
//  Created by Shiva Raj on 11/8/23.
//

import Foundation
import CoreData

class ExpenseViewModel: ObservableObject {
    
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
    
    func calculateTotalAmountAndCountByTransactionType(context: NSManagedObjectContext) -> [DataStructs.TransactionTypeGrouped] {
        let fetchRequest = NSFetchRequest<Expense>(entityName: "Expense")
        
        // Calculate the start date and end date for the current month
        let calendar = Calendar.current
        let currentDate = Date()
        let startDateComponents = calendar.dateComponents([.year, .month], from: currentDate)
        let startDate = calendar.date(from: startDateComponents)!
        let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startDate)!
        
        // Create a predicate to filter expenses for the current month
        let predicate = NSPredicate(format: "expenseDate >= %@ AND expenseDate <= %@", startDate as CVarArg, endOfMonth as CVarArg)
        fetchRequest.predicate = predicate
        
        do {
            let results = try context.fetch(fetchRequest)
            
            // Use reduce to calculate total amount and count
            let totalAmountAndCountByTransactionType = results.reduce(into: [String: DataStructs.TransactionTypeGrouped.TransactionTypeValues]()) { result, expense in
                if let transactionType = expense.transactionType {
                    let amount = expense.amount
                    result[transactionType, default: DataStructs.TransactionTypeGrouped.TransactionTypeValues(totalAmount: 0, count: 0)].totalAmount += amount
                    result[transactionType, default: DataStructs.TransactionTypeGrouped.TransactionTypeValues(totalAmount: 0, count: 0)].count += 1
                }
            }
            
            // Convert the dictionary values to an array of TransactionTypeGrouped
            let resultArray = totalAmountAndCountByTransactionType.map { key, value in
                DataStructs.TransactionTypeGrouped(data: [key: value])
            }
            
            return resultArray
        } catch {
            print("Error fetching category sums: \(error)")
        }
        
        return [DataStructs.TransactionTypeGrouped(data: [:])]
    }
        
}
