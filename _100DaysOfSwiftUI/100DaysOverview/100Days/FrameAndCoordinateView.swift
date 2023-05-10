//
//  FrameAndCoordinateView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 10/05/2023.
//

import SwiftUI

struct FrameAndCoordinateView: View {
    var body: some View {
        VStack {
            GeometryReader { geo in
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    .frame(width: geo.size.width * 0.9)
                    .background(.red)
            }
            .background(.green)
            Text("More text")
            Text("More text")
            Text("More text")
            Text("More text")
                .background(.blue)
        }
    }
}

struct FrameAndCoordinateView_Previews: PreviewProvider {
    static var previews: some View {
        FrameAndCoordinateView()
    }
}
