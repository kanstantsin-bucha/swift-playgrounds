//
//  SpecialEffectsView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 02/02/2023.
//

import SwiftUI

struct SpecialEffectsView: View {
    var body: some View {
        VStack {
            ZStack {
                Image("Image")
                    .resizable()
                Rectangle()
                    .fill(.red)
                    .blendMode(.multiply)
            }
            Image("Image")
                .resizable()
                .colorMultiply(.green)
        }
    }
}

struct SpecialEffectsView_Previews: PreviewProvider {
    static var previews: some View {
        SpecialEffectsView()
    }
}
