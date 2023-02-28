//
//  EditView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 24/02/2023.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name: String
    @State private var description: String
    
    var location: SecondLocation
    var onSave: (SecondLocation) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $name)
                    TextField("Place description", text: $description)
                }
            }
            .navigationTitle("Place Detail")
            .toolbar {
                Button("Save") {
                    var newLocation = location
                    newLocation.id = UUID()
                    newLocation.name = name
                    newLocation.description = description
                    onSave(newLocation)
                    dismiss()
                }
            }
        }
    }
    
    init(location: SecondLocation, onSave: @escaping(SecondLocation) -> Void) {
        self.location = location
        self.onSave = onSave
        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: SecondLocation.example) { _ in }
    }
}
