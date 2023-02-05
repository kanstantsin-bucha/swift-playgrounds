//
//  GeometryReader.swift
//  SwiftUI1
//
//  Created by Kanstantsin Bucha on 24/01/2023.
//

import SwiftUI

struct GeometryReaderV: View {
    private let gradient = Gradient(colors: [
        Color(red: 1, green: 0.1, blue: 0.1),
        Color(red: 0.1, green: 0.1, blue: 1),
    ])
    
    var body: some View {
        VStack(alignment: .center) {
            GeometryReader { g in
                HStack(alignment: .center) {
                    Spacer()
                    VStack(alignment: .center) {
                        Spacer()
                        LinearGradient(
                            gradient: gradient,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .frame(
                            width: g.size.width * 0.8,
                            height: g.size.height * 0.5
                        )
                        // if view have a position modifier - it takes all available parent's space
//                        .position(
//                            x: (g.size.width * 0.8) / 2,
//                            y: (g.size.height * 0.5) / 2
//                        )
                        .background(.green)
                        Spacer()
                    }
                    .background(.orange)
                    Spacer()
                }
            }
            .background(.mint)
        }
        .coordinateSpace(name: "Space")
    }
}

struct GeometryReaderV_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderV()
//            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
    }
}
