//
//  DeletingView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 27/01/2023.
//

import SwiftUI

struct DeletingView: View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    var body: some View {
        NavigationView {
            VStack{
                List {
                    ForEach(numbers, id: \.self) {
                        Text("Row \($0)")
                    }
                    .onDelete(perform: removeRow)
                }
                Button("Add number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
            }
            .navigationTitle("Delete func")
            .toolbar {
                EditButton()
            }
        }
    }
    func removeRow(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

struct DeletingView_Previews: PreviewProvider {
    static var previews: some View {
        DeletingView()
    }
}
