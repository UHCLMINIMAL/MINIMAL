//
//  CategoryView.swift
//  MinimalExpense
//
//  Created by Shiva Raj on 11/28/23.
//

import SwiftUI

struct CategoryView: View {
    
    let categories = ["Groceries", "LifeStyle", "Travel", "Health"]
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(categories, id: \.self) { category in
                    CardView(title: category, image: category)
                        .padding()
                }
            }
        }
    }
}

struct CardView: View, Identifiable {
    
    let id = UUID()
    var title: String
    var image: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(radius: 3)

            Text(title)
                .font(.headline)
                .padding()
            
            Image(image) // Assuming image is a system name
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .padding()
        }
        .frame(width: 200, height: 300)
    }
}

#Preview {
    CategoryView()
}
