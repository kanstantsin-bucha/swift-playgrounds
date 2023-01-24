//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport
import Foundation

struct ContentView: View {
    @Binding var gradient: Gradient
    
    var body: some View {
        Rectangle()
            .overlay(
                GeometryReader { g in
//                    Print("geometry \(g.size)")
                    LinearGradient(
                        gradient: gradient,
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                        .frame(width: g.size.width, height: g.size.height, alignment: .center)
                        .scaleEffect(x: 1.0, y: 1.0, anchor: .leading)
                }
            )
            .frame(width: 300, height: 300)
            .background(.mint)
    }
}

struct AppState {
    @State var gradient = Gradient(colors: [
        Color(red: 1, green: 0.1, blue: 0.1),
        Color(red: 0.1, green: 0.1, blue: 1),
    ])
}

let state = AppState()

// MARK: - Preview

struct Container: View {
    var body: some View {
        ContentView(gradient: state.$gradient)
            .frame(width: 395, height: 700)
    }
}
import PlaygroundSupport
PlaygroundPage.current.setLiveView(Container())

//: [Next](@next)

