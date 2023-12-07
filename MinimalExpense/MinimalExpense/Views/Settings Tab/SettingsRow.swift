//
//  SettingsRow.swift
//  MinimalExpense
//
//  Created by Shiva Raj on 11/16/23.
//

import SwiftUI

struct SettingsRow: View {
    
    let settingsRow:String?
    
    var body: some View {
        
        HStack(spacing: 20) {
            
            Image(settingsRow ?? "")
            Text(settingsRow ?? "")
        }
        .padding([.top, .bottom], 8)
    }
}
