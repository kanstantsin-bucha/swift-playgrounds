//
//  ReduceTransparencyView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 19/04/2023.
//

import SwiftUI

struct ReduceTransparencyView: View {
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .padding()
            .background(reduceTransparency ? .black : .black.opacity(0.5))
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}

struct ReduceTransparencyView_Previews: PreviewProvider {
    static var previews: some View {
        ReduceTransparencyView()
    }
}
