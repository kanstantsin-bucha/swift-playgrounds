//
//  HorizontalScrollViewWithGeometryReaderView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 12/05/2023.
//

import SwiftUI

struct HorizontalScrollViewWithGeometryReaderView: View {
    let colors: [Color] = [.red, .green,.blue,.orange,.pink,.purple,.yellow]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(0..<20) { number in
                    GeometryReader { geo in
                        Text("Number \(number)")
                            .font(.largeTitle)
                            .padding()
                            .background(.gray)
                            .rotation3DEffect(.degrees(-geo.frame(in: .global).minX) / 8 , axis: (x: 0, y: 1, z: 0))
                            .frame(width: 200, height: 200)
                    }
                    .frame(width: 200, height: 200)
                }
            }
        }
    }
}

struct HorizontalScrollViewWithGeometryReaderView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalScrollViewWithGeometryReaderView()
    }
}
