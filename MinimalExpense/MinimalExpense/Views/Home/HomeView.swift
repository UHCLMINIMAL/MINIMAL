//
//  ContentView.swift
//  MinimalExpense
//
//  Created by Shiva Raj on 11/8/23.
//

import SwiftUI
import CoreData

struct HomeView: View {
    
    var body: some View {
        
        ZStack {
            TabView {
                // Tab 1
                HomeTabView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                
                // Tab 2
                Text("Budget")
                    .tabItem {
                        Image(systemName: "dollarsign")
                        Text("Budget")
                    }
                
                // Tab 3
                ReportView()
                    .tabItem {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                        Text("Reports")
                    }
                
                // Tab 3
                SettingsTab()
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
                
                // Tab 3
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    
                    FloatingActionButton()
                }
                .padding()
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct FloatingActionButton: View {
    
    @State private var isAddExpenseViewPresented = false
    
    var body: some View {
        Button(action: {
            isAddExpenseViewPresented.toggle()
        }) {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .background(Color.white)
                .foregroundColor(.minimalTheme)
                .cornerRadius(25)
                .padding()
        }
        .offset(y: -30) // Adjust the Y offset to position the button
        .fullScreenCover(isPresented: $isAddExpenseViewPresented) {
            AddExpenseView()
        }
    }
}

#Preview {
    HomeView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
