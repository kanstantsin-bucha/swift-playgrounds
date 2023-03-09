//
//  ReadingTheValueOfControlsView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 01/03/2023.
//

import SwiftUI

struct ReadingTheValueOfControlsView: View {
    @State private var value = 10
    var body: some View {
        VStack {
            Text("Value: \(value)")
            Button("Increment") {
                value += 1
            }
            Button("Decrement") {
                value -= 1
            }
        }
        .accessibilityElement()
        .accessibilityLabel("Value")
        .accessibilityValue(String(value))
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                value += 1
            case .decrement:
                value -= 1
            @unknown default:
                print("Some action")
            }
        }
    }
}

struct ReadingTheValueOfControlsView_Previews: PreviewProvider {
    static var previews: some View {
        ReadingTheValueOfControlsView()
    }
}
