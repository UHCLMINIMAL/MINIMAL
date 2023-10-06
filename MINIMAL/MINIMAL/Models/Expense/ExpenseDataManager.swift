//
//  ExpenseDataManager.swift
//  MINIMAL
//
//  Created by Shiva Raj on 10/5/23.
//

import UIKit

class ExpenseDataManager: NSObject {
    static func fetchAllExpenses() -> [Expense] {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            
            do {
                let expenses = try managedContext.fetch(Expense.fetchRequest())
                return expenses
            } catch {
                //error
            }
        }
        
        return []

    }
}
