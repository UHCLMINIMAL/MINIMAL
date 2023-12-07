//
//  SettingsTab.swift
//  MinimalExpense
//
//  Created by Shiva Raj on 11/16/23.
//

import SwiftUI

struct SettingsTab: View {
    
    let settings = ["Account", "Notifications", "Appearance", "Privacy & Security", "Help & Support", "About"]
    
    var body: some View {
        
        NavigationView {
            
            List(settings, id: \.self) { setting in
                NavigationLink(destination: Text(setting)) {
                    SettingsRow(settingsRow: setting)
                }
            }
            .navigationTitle("Settings")
        }
    }
}
