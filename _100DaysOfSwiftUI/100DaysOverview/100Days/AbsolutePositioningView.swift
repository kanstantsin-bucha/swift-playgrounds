//
//  AbsolutePositioningView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 10/05/2023.
//

import SwiftUI

struct AbsolutePositioningView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Hello, World!")
            // That modifier  only Text
                .background(.red)
                .position(x: 100, y: 100)
            // That modifier  all screen
            //            .background(.red)
            
            Text("Hello!")
                .offset(x: -100, y: -100)
                .background(.red)
            
            Text("World!")
                .background(.red)
                .offset(x: 100, y: -100)
            Spacer()
        }
    }
}

struct AbsolutePositioningView_Previews: PreviewProvider {
    static var previews: some View {
        AbsolutePositioningView()
    }
}
