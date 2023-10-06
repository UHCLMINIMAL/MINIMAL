//
//  Expense+CoreDataProperties.swift
//  MINIMAL
//
//  Created by Shiva Raj on 10/5/23.
//
//

import Foundation
import CoreData


extension Expense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expense> {
        return NSFetchRequest<Expense>(entityName: "Expense")
    }

    @NSManaged public var title: String?
    @NSManaged public var transactionType: String?
    @NSManaged public var amoount: Float
    @NSManaged public var expenseDate: Date?
    @NSManaged public var category: String?

}

extension Expense : Identifiable {
    
}
