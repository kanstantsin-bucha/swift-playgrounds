//
//  ContentView.swift
//  Shared
//
//  Created by Kanstantsin Bucha on 11/12/2021.
//

import SwiftUI
import PWSLibrary

struct ContentView: View {
    @Binding var gradient: Gradient
    
    var body: some View {
        Rectangle()
            .overlay(
                GeometryReader { g in
                    Print("geometry \(g.size)")
                    LinearGradient(
                        gradient: gradient,
                        startPoint: .top,
                        endPoint: .bottom
                    )
                        .frame(width: g.size.width, height: g.size.height, alignment: .center)
                        .scaleEffect(x: 1.0, y: 1.0, anchor: .leading)
                }
            )
            .background(.mint)
            .ignoresSafeArea(.keyboard)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(gradient: state.$gradient)
            
            
    }
}
