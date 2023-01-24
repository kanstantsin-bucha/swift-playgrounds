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

PlaygroundPage.current.setLiveView(ContentView(gradient: state.$gradient))

//: [Next](@next)

