//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Kanstantsin Bucha on 14/01/2023.
//

import SwiftUI

struct ContentView: View {
    @State var isAnimated = false

    var body: some View {
        ZStack {
            RadialGradient(
                gradient:
                    Gradient(stops: [
                        .init(color: .blue, location: 0.01),
                        .init(color: .black, location: 0.30),
                        .init(color: .white, location: 0.65),
                        .init(color: .gray, location: 0.8),
                    ]),
                center: .center,
                startRadius: 0,
                endRadius: 250
            )
            RadialGradient(
                gradient:
                    Gradient(stops: [
                        .init(color: .blue, location: 0.01),
                        .init(color: .black, location: 0.3),
                        .init(color: .white, location: 0.65),
                        .init(color: .gray, location: 0.8),
                    ]),
                center: .center,
                startRadius: 0,
                endRadius: 250
            )
            .opacity(isAnimated ? 1 : 0)
            RadialGradient(
                gradient:
                    Gradient(stops: [
                        .init(color: .blue, location: 0.03),
                        .init(color: .black, location: 0.43),
                        .init(color: .white, location: 0.72),
                        .init(color: .gray, location: 0.8),
                    ]),
                center: .center,
                startRadius: 0,
                endRadius: 250
            )
            .opacity(isAnimated ? 0 : 1)
        }
//        .frame(width: isAnimated ? 300 : 330, height: isAnimated ? 300 : 330, alignment: .center)
        .onTapGesture {
            withAnimation(.easeInOut(duration: 1).repeatCount(10)) {
                isAnimated.toggle()
            }
        }
        .ignoresSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
