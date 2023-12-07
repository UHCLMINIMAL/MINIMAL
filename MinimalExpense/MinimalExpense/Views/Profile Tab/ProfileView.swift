//
//  ProfileView.swift
//  MinimalExpense
//
//  Created by Shiva Raj on 11/16/23.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                Image(systemName: "person")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 1))
                    .frame(width: 55, height: 55)
                
                
                Text("username")
                Text("xyz@gmail.com")
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .navigationTitle("Profile")
        }
    }
}

