//
//  ColorCyclingView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 02/02/2023.
//

import SwiftUI

struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(value: value, brightness: 1),
                                color(value: value, brightness: 0.5)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 2
                    )
            }
        }
        .drawingGroup()
    }
    
    func color(value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        if targetHue > 1 {
            targetHue -= 1
        }
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ColorCyclingView: View {
    @State private var colorCircle = 0.0
    var body: some View {
        VStack {
            Spacer()
            ColorCyclingCircle(amount: colorCircle)
                .frame(width: 300,height: 300)
            Spacer()
            Slider(value: $colorCircle)
                .padding(10)
            Spacer()
        }
    }
}

struct ColorCyclingView_Previews: PreviewProvider {
    static var previews: some View {
        ColorCyclingView()
    }
}
