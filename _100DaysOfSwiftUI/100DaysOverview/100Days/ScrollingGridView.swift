//
//  ScrollingGridView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 30/01/2023.
//

import SwiftUI

struct ScrollingGridView: View {
    let layout = [
        GridItem(.adaptive(minimum: 80))
    ]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: layout) {
                ForEach(0..<1000) {
                    Text("Item \($0)")
                }
            }
        }
    }
}

struct ScrollingGridView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollingGridView()
    }
}
