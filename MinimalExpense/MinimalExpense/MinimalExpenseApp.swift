//
//  MinimalExpenseApp.swift
//  MinimalExpense
//
//  Created by Shiva Raj on 11/8/23.
//

import SwiftUI

@main
struct MinimalExpenseApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
