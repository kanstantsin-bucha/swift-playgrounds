//: [Previous](@previous)

import SwiftUI

struct Item: Identifiable {
    var id = UUID()
    var name: String
    var age: Int
}

struct Child: View {
    @Binding var item: Item?
    @State private var name: String = ""
    @State private var age: Int = 0
    
    var body: some View {
        VStack {
            Form {
                TextField("name", text: $name)
                TextField("age", value: $age, format: .number)
            }
            Spacer()
            Button("Save") {
                item?.name = name
                item?.age = age
                item?.id = UUID()
            }
            .foregroundColor(.white)
            .padding()
            .clipShape(Capsule())
            .tint(Color.blue)
            .padding()
        }
        .onAppear {
            item.map {
                name = $0.name
                age = $0.age
            }
        }
    }
}

struct Parent: View {
    @State private var items = [
        Item(name: "Nick", age: 27),
        Item(name: "Mike", age: 35),
        Item(name: "Nikole", age: 18),
    ]
    @State private var editItem: Item?
    @State private var isEditing = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    ForEach(items, id: \.name) { item in
                        Text("\(item.name) \(item.age)")
                            .swipeActions {
                                Button {
                                    editItem = item
                                    isEditing = true
                                } label: {
                                    Label("Edit", systemImage: "pencil")
                                }
                                .tint(.orange)
                            }
                    }
                    
                }
            }
            .navigationTitle("Data Flow")
        }
        .sheet(isPresented: $isEditing) {
            Child(item: $editItem)
        }
    }
}

// MARK: - Preview

struct Container: View {
    var body: some View {
        Parent()
            .frame(width: 300, height: 600)
    }
}
import PlaygroundSupport
PlaygroundPage.current.setLiveView(Container())

//: [Next](@next)
