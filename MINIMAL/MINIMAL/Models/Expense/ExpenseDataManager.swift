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
            let sortDescriptor = NSSortDescriptor(key: "createdOn", ascending: false)
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
                newExpense.createdOn = Date()
                
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
    
    static func calculateTotalAmountAndCountByTransactionType() -> [String: (totalAmount: Float, count: Int)] {
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
                
                // Use reduce to calculate total amount and count
                let totalAmountAndCountByTransactionType = expenses.reduce(into: [String: (totalAmount: Float, count: Int)]()) { result, expense in
                    if let transactionType = expense.transactionType {
                        let amount = expense.amount
                        result[transactionType, default: (totalAmount: 0, count: 0)].totalAmount += amount
                        result[transactionType, default: (totalAmount: 0, count: 0)].count += 1
                    }
                }
                
                return totalAmountAndCountByTransactionType
                
            } catch {
                print("Error calculating total amount and count by transaction type: \(error)")
            }
        }
        
        return [:]
    }
    
    static func delete(expense: Expense, competion: @escaping () -> Void) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            
            //Saving the context to persist the data
            managedContext.delete(expense)
            competion()
        }
    }
    
}
