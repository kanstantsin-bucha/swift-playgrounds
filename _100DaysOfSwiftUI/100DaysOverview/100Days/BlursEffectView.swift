//
//  BlursEffectView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 02/02/2023.
//

import SwiftUI

struct BlursEffectView: View {
    @State private var amount = 0.0
    
    var body: some View {
        VStack{
            Image("Image")
                .resizable()
                .scaledToFill()
                .frame(width: 300, height: 300)
                .saturation(amount)
                .blur(radius: (1 - amount) * 20)
            Slider(value: $amount)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .ignoresSafeArea()
    }
}

struct BlursEffectView_Previews: PreviewProvider {
    static var previews: some View {
        BlursEffectView()
    }
}
