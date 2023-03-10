//
//  ContextMenusView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 10/03/2023.
//

import SwiftUI

struct ContextMenusView: View {
    @State private var backgroundColor = Color.red
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .background(backgroundColor)
                .padding()
            Text("Change Color")
                .padding()
                .contextMenu {
                    Button(role: .destructive) {
                            backgroundColor = .red
                        } label: {
                            Label("Red", systemImage: "circle.fill")
                                .foregroundColor(.red)
                        }
                        Button("Green") {
                            backgroundColor = .green
                        }
                        Button("Blue") {
                            backgroundColor = .blue
                        }
                }
        }
    }
}

struct ContextMenusView_Previews: PreviewProvider {
    static var previews: some View {
        ContextMenusView()
    }
}
