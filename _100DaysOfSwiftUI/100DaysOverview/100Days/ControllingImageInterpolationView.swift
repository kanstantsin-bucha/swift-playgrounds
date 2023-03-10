//
//  ControllingImageInterpolationView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 10/03/2023.
//

import SwiftUI

struct ControllingImageInterpolationView: View {
    var body: some View {
        Image("example")
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .frame(maxHeight: .infinity)
            .background(.black)
            .ignoresSafeArea()
    }
}

struct ControllingImageInterpolationView_Previews: PreviewProvider {
    static var previews: some View {
        ControllingImageInterpolationView()
    }
}
