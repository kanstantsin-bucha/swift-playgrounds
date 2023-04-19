//
//  AccessibilityView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 19/04/2023.
//

import SwiftUI

struct AccessibilityView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    
    var body: some View {
        HStack {
            if differentiateWithoutColor {
                Image(systemName: "checkmark.circle")
            }
            Text("Success")
                .padding()
                .background(differentiateWithoutColor ? .black : .green)
                .foregroundColor(.white)
                .clipShape(Capsule())
        }
    }
}

struct AccessibilityView_Previews: PreviewProvider {
    static var previews: some View {
        AccessibilityView()
    }
}
