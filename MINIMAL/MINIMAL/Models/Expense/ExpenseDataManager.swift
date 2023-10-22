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
            
            do {
                let expenses = try managedContext.fetch(fetchRequest)
                return expenses
            } catch {
                //error
            }
        }
        return []
    }
    
    // function to save expenses
    static func saveExpense(title: String, transactionType: String, amount: Float, category: String, expenseDate: Date) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            
            if let newExpense = NSEntityDescription.insertNewObject(forEntityName: "Expense", into: managedContext) as? Expense {
                newExpense.expenseID = UUID()
                newExpense.title = title
                newExpense.transactionType = transactionType
                newExpense.amoount = amount
                newExpense.category = category
                newExpense.expenseDate = expenseDate
                newExpense.updatedOn = Date()
                
                //Saving the context to persist the data
                do {
                    try managedContext.save()
                    print("Data saved successfully.")
                } catch {
                    print("Unable to save the Expense")
                }
            }
        }
    }
}
