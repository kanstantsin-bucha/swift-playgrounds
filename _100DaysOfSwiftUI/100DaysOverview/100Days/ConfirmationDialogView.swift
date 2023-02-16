//
//  ConfirmationDialogView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 16/02/2023.
//

import SwiftUI

struct ConfirmationDialogView: View {
    @State private var isShowConfirmation = false
    @State private var backgroundColor = Color.white
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .frame(width: 300, height: 300)
                .background(backgroundColor)
                .onTapGesture {
                    isShowConfirmation = true
                }
                .confirmationDialog("Chose the color", isPresented: $isShowConfirmation) {
                    Button("Red") {
                        backgroundColor = .red
                    }
                    Button("Green") {
                        backgroundColor = .green
                    }
                    Button("Cyan") {
                        backgroundColor = .cyan
                    }
                    
                    Button("Cancel", role: .cancel) { }
                } message: {
                    Text("Select a new color")
                }
        }
    }
}

struct ConfirmationDialogView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationDialogView()
    }
}
