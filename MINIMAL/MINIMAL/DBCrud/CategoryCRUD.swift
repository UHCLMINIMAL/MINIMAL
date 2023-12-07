//
//  CategoryCRUD.swift
//  MINIMAL
//
//  Created by Tahoor Ahmed Mohammed on 11/27/23.
//

import UIKit
import CoreData

class CategoryCRUD: NSObject {
    
    required init(context: NSManagedObjectContext) {
        super.init()
    }
    
    func addMasterData() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext

            let categoryEntity = NSEntityDescription.entity(forEntityName: "Category", in: managedContext)!

            // Create and add Housing Category
            let housingCategory = NSManagedObject(entity: categoryEntity, insertInto: managedContext)
            housingCategory.setValue(UUID(), forKey: "categoryID")
            housingCategory.setValue("Housing", forKey: "categoryName")
            housingCategory.setValue("house.fill", forKey: "icon")
            housingCategory.setValue(nil, forKey: "parentCategory")
            housingCategory.setValue(1, forKey: "sortValue")

            // Create and add Travel Category
            let travelCategory = NSManagedObject(entity: categoryEntity, insertInto: managedContext)
            travelCategory.setValue(UUID(), forKey: "categoryID")
            travelCategory.setValue("Travel", forKey: "categoryName")
            travelCategory.setValue("car.side.fill", forKey: "icon")
            travelCategory.setValue(nil, forKey: "parentCategory")
            travelCategory.setValue(2, forKey: "sortValue")

            // Create and add Lifestyle Category
            let lifestyleCategory = NSManagedObject(entity: categoryEntity, insertInto: managedContext)
            lifestyleCategory.setValue(UUID(), forKey: "categoryID")
            lifestyleCategory.setValue("Lifestyle", forKey: "categoryName")
            lifestyleCategory.setValue("bag", forKey: "icon")
            lifestyleCategory.setValue(nil, forKey: "parentCategory")
            lifestyleCategory.setValue(3, forKey: "sortValue")

            // Create and add Food Category
            let foodCategory = NSManagedObject(entity: categoryEntity, insertInto: managedContext)
            foodCategory.setValue(UUID(), forKey: "categoryID")
            foodCategory.setValue("Food", forKey: "categoryName")
            foodCategory.setValue("fork.knife.circle", forKey: "icon")
            foodCategory.setValue(nil, forKey: "parentCategory")
            foodCategory.setValue(4, forKey: "sortValue")

            // Create and add Health Category
            let healthCategory = NSManagedObject(entity: categoryEntity, insertInto: managedContext)
            healthCategory.setValue(UUID(), forKey: "categoryID")
            healthCategory.setValue("Health", forKey: "categoryName")
            healthCategory.setValue("cross.case", forKey: "icon")
            healthCategory.setValue(nil, forKey: "parentCategory")
            healthCategory.setValue(5, forKey: "sortValue")

            // Create and add Misc Category
            let miscCategory = NSManagedObject(entity: categoryEntity, insertInto: managedContext)
            miscCategory.setValue(UUID(), forKey: "categoryID")
            miscCategory.setValue("Misc", forKey: "categoryName")
            miscCategory.setValue("list.bullet", forKey: "icon")
            miscCategory.setValue(nil, forKey: "parentCategory")
            miscCategory.setValue(6, forKey: "sortValue")

            do {
                try managedContext.save()
                print("Master data added successfully.")
            } catch let error as NSError {
                print("Failed to add master data: \(error)")
            }
        }
    }

    func checkMasterData() -> Bool {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext

            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Category")
            fetchRequest.fetchLimit = 1

            do {
                let rowCount = try managedContext.count(for: fetchRequest)
                return rowCount > 0
            } catch let error as NSError {
                print("Failed to check master data: \(error)")
                return false
            }
        }

        return false
    }

    func getAllCategories() -> [Category] {
        if !checkMasterData() {
            addMasterData()
        }
        let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<Category>(entityName: "Category")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "sortValue", ascending: true)]

        do {
            let categories = try managedContext!.fetch(fetchRequest)
            return categories
        } catch let error as NSError {
            print("Failed to fetch categories: \(error)")
            return []
        }
    }
    
    //done


}
