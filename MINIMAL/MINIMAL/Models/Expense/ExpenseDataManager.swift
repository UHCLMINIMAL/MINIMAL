//
//  ExpenseDataManager.swift
//  MINIMAL
//
//  Created by Shiva Raj on 10/5/23.
//

import UIKit
import CoreData

class ExpenseDataManadger: NSObject {
    
    // function to fetech All Expenses
    static func fetchAllExpenses() -> [Expense] {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<Expense> = Expense.fetchRequest()
            
            // Create a sort descriptor to sort by the 'expenseDate' attribute in ascending order
            let sortDescriptor = NSSortDescriptor(key: "expenseDate", ascending: false)
            fetchRequest.sortDescriptors = [sortDescriptor]
            
            do {
                let expenses = try managedContext.fetch(fetchRequest)
                return expenses
            } catch {
                // Handle the error
                print("Error fetching expenses: \(error)")
            }
        }
        return []
    }
    
    // function to save expenses
    static func saveExpense(title: String, transactionType: String, amount: Float, category: String, expenseDate: Date, competion: @escaping () -> Void) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            
            if let newExpense = NSEntityDescription.insertNewObject(forEntityName: "Expense", into: managedContext) as? Expense {
                newExpense.expenseID = UUID()
                newExpense.title = title
                newExpense.transactionType = transactionType
                newExpense.amount = amount
                newExpense.category = category
                newExpense.expenseDate = expenseDate
                newExpense.updatedOn = Date()
                
                //Saving the context to persist the data
                do {
                    try managedContext.save()
                    competion()
                } catch {
                    print("Unable to save the Expense")
                }
            }
        }
    }
    
    static func calculateTotalAmountByTransactionType() -> [String: Float] {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let fetchRequest: NSFetchRequest<Expense> = Expense.fetchRequest()
            
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
                let expenses = try managedContext.fetch(fetchRequest)
                
                // Create a dictionary to store the total amount for each transaction type
                var totalAmountByTransactionType: [String: Float] = [:]
                
                for expense in expenses {
                    if let transactionType = expense.transactionType {
                        let amount = expense.amount
                        totalAmountByTransactionType[transactionType, default: 0.0] += amount
                    }
                }
                
                return totalAmountByTransactionType
                
            } catch {
                print("Error calculating total amount by transaction type: \(error)")
            }
        }
        
        return [:]
    }
}
