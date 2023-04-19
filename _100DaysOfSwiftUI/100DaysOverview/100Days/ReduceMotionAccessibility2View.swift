//
//  ReduceMotionAccessibility2View.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 19/04/2023.
//

import SwiftUI

func withOptionalAnimation<Result>(_ animation: Animation? = .default,_ body: () throws -> Result) rethrows -> Result {
    if UIAccessibility.isReduceMotionEnabled {
        return try body()
    } else {
        return try withAnimation(animation, body)
    }
}

struct ReduceMotionAccessibility2View: View {
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @State private var scale = 1.0
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .scaleEffect(scale)
            .onTapGesture {
                withOptionalAnimation {
                    scale *= 1.5
                }
            }
    }
}

struct ReduceMotionAccessibility2View_Previews: PreviewProvider {
    static var previews: some View {
        ReduceMotionAccessibility2View()
    }
}
