//
//  BookCURD.swift
//  tahoor-book-library
//
//  Created by Tahoor Mohammed on 10/31/23.
//

import UIKit
import CoreData

class BudgetCRUD: NSObject {
    
    required init(context: NSManagedObjectContext) {
        super.init()
    }
    
    static func addBudget(amount:Float, period:Int) -> Bool{
        //Get the managed context context from AppDelegate
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let budgetID = UUID()

            let managedContext = appDelegate.persistentContainer.viewContext
            //Create a new empty record.
            let bookEntity = NSEntityDescription.entity(forEntityName: "Budget", in: managedContext)!
            //Fill the new record with values
            let book = NSManagedObject(entity: bookEntity, insertInto: managedContext)
            book.setValue(amount, forKey: "budgetAmount")
            book.setValue(0, forKey: "spentAmount")
            book.setValue(period, forKey: "budgetPeriod")
            book.setValue("Monthly", forKey: "budgetType")
            book.setValue(Date(), forKey: "createdOn")
            book.setValue(budgetID, forKey: "budgetID")
            do {
                //Save the managed object context
                try managedContext.save()
                print("Budget added successfully. BudgetID: " + budgetID.uuidString)
                return true
            } catch let error as NSError {
                print("Could not add the new budget! \(error), \(error.userInfo)")
            }
        }
        return false
    }
    
    static func getBudget(period: Int) -> Budget? {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext

            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Budget")

            fetchRequest.predicate = NSPredicate(format: "budgetPeriod == %@", period as CVarArg)
            
            do {
                let records = try managedContext.fetch(fetchRequest) as? [Budget]
                if records != nil && records!.count > 0 {
                    return records![0]
                }
            } catch let error as NSError {
                print("Could not fetch budget! \(error), \(error.userInfo)")
                return nil
            }
        }
        return nil
    }
    
//    static func updateBook(id: String, title: String, dueDate: Date, author: String, subject: String) -> Bool{
//        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
//            let managedContext = appDelegate.persistentContainer.viewContext
//
//            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BooksLibrary")
//            fetchRequest.predicate = NSPredicate(format: "bookID == %@", UUID(uuidString: id)! as CVarArg)
//
//            do {
//                if let book = try managedContext.fetch(fetchRequest).first as? NSManagedObject {
//                    // Update the record
//                    book.setValue(title, forKey: "title")
//                    book.setValue(dueDate, forKey: "dueDate")
//                    book.setValue(author, forKey: "author")
//                    book.setValue(subject, forKey: "subjectName")
//
//                    // Save the managed object context
//                    do {
//                        try managedContext.save()
//                        print("Updated the book record! ID: \(id)")
//                        return true
//                    }
//                    catch let error as NSError {
//                        print("Could not update the book record! \(error), \(error.userInfo)")
//                    }                }
//            } catch let error as NSError {
//                print("Book with ID: \(id) NOT FOUND! \(error), \(error.userInfo)")
//            }
//        }
//        return false
//    }
    
//    static func delete(id: String) {
//        //Get the managed context context from AppDelegate
//        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
//            let managedContext = appDelegate.persistentContainer.viewContext
//            
//            //Prepare a fetch request for the record to delete
//            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BooksLibrary")
//            fetchRequest.predicate = NSPredicate(format: "bookID == %@", UUID(uuidString: id)! as CVarArg)
//            
//            do {
//                //Fetch the record to delete
//                if let book = try managedContext.fetch(fetchRequest).first as? NSManagedObject {
//                    //Delete the record
//                    managedContext.delete(book)
//                }
//            
//                do {
//                    try managedContext.save()
//                }
//                catch let error as NSError {
//                    print("Could not delete the book record! \(error), \(error.userInfo)")
//                }
//            }
//            catch let error as NSError {
//                print("Book with ID: \(id) NOT FOUND! \(error), \(error.userInfo)")
//            }
//            
//        }
//    }
//
//    static func deleteAllRows() {
//        // Get the managed context context from AppDelegate
//        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
//            let managedContext = appDelegate.persistentContainer.viewContext
//
//            // Create a batch delete request for all BooksLibrary records
//            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: "BooksLibrary"))
//
//            // Execute the batch delete request
//            do {
//                try managedContext.execute(batchDeleteRequest)
//
//                // Save the changes
//                try managedContext.save()
//            } catch let error {
//                // Print an error if something goes wrong
//                print("Error deleting all books: \(error)")
//            }
//        }
//    }



}
