//
//  ParentChildDataFlow.swift
//  SwiftUI1
//
//  Created by Kanstantsin Bucha on 24/01/2023.
//

import SwiftUI

struct Item: Hashable, Identifiable, Comparable {
    var id = UUID()
    var name: String
    var age: Int
    
    static func <(lhs: Item, rhs: Item) -> Bool {
        lhs.name < rhs.name
    }
    
    static var example: Self {
        Item(name: "Mark", age: 50)
    }
}

struct Parent: View {
    @State private var items = [
        Item(name: "Nick", age: 27),
        Item(name: "Mike", age: 35),
        Item(name: "Nikole", age: 18),
    ]
    @State private var editItem: Item?
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    ForEach(items.sorted(), id: \.self) { item in
                        Text("\(item.name) \(item.age)")
                            .swipeActions {
                                Button {
                                    editItem = item
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
        .sheet(item: $editItem) { item in
            Child(item: item) { item in
                var updatedItems = items.filter { $0.id != item.id }
                updatedItems.append(item)
                items = updatedItems
            }
        }
    }
}

struct ParentChildDataFlow: View {
    var body: some View {
        Parent()
    }
}

struct Parent_Previews: PreviewProvider {
    static var previews: some View {
        Parent()
//            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
    }
}

