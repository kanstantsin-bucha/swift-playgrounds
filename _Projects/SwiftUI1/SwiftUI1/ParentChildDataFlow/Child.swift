//
//  Child.swift
//  SwiftUI1
//
//  Created by Kanstantsin Bucha on 24/01/2023.
//

import SwiftUI

struct Child: View {
    let item: Item
    let onSave: (Item) -> Void
    @State private var name: String = ""
    @State private var age: Int = 0
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Form {
                TextField("name", text: $name)
                TextField("age", value: $age, format: .number)
            }
            Button("Save") {
                var itemToSave = item
                itemToSave.name = name
                itemToSave.age = age
                onSave(itemToSave)
                dismiss()
            }
            .font(.headline)
            .padding()
            .padding(.horizontal)
            .foregroundColor(.white)
            .background(Color.blue)
            .clipShape(Capsule())
            .padding()
            Spacer()
        }
        .onAppear {
            name = item.name
            age = item.age
        }
    }
}

struct Child_Previews: PreviewProvider {
    static var previews: some View {
        Child(item: .example, onSave: { _ in })
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
    }
}

