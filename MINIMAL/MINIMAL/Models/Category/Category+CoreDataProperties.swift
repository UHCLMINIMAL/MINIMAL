//
//  Category+CoreDataProperties.swift
//  MINIMAL
//
//  Created by Shiva Raj on 10/19/23.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var category: String?
    @NSManaged public var categoryID: UUID?
    @NSManaged public var parentCategory: String?

}

extension Category : Identifiable {

}
