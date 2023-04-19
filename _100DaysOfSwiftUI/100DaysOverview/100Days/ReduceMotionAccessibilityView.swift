//
//  ReduceMotionAccessibilityView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 19/04/2023.
//

import SwiftUI

struct ReduceMotionAccessibilityView: View {
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @State private var scale = 1.0
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .scaleEffect(scale)
            .onTapGesture {
                if reduceMotion {
                    scale *= 1.5
                } else {
                    withAnimation {
                        scale *= 1.5
                    }
                }
            }
    }
}

struct ReduceMotionAccessibilityView_Previews: PreviewProvider {
    static var previews: some View {
        ReduceMotionAccessibilityView()
    }
}
