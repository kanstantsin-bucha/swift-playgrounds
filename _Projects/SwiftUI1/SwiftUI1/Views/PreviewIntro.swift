//
//  PreviewIntro.swift
//  SwiftUI1
//
//  Created by Kanstantsin Bucha on 24/01/2023.
//

import SwiftUI

struct PreviewsIntro: View {
    var body: some View {
        // Print changes that make view reload the body
        let _ = Self._printChanges()
        VStack(spacing: 20) {
            Text("Previews")
                .font(.largeTitle)
            Text("Introduction")
                .foregroundColor(.gray)
            Text("Xcode looks for a struct that conforms to the PreviewProvider protocol and accesses its previews property to display a view on the Canvas.")
                .fixedSize(horizontal: false, vertical: true)
                .background(Color.red)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
            /*
             Each modifier returns a view, so hierarchy is
             * Background blue
                * Padding
                    * Foreground White
                        * Background Red
                            * Fixed size view
                                * Text
             */
            Text("A single line of text, too long to fit in a box.")
                .fixedSize(horizontal: true, vertical: false)
                .frame(width: 200, height: 200)
                .border(Color.gray)
            /*
             fixedSize ask Text to maintain its best width
             which results in a single line of text
             */
        }
        .font(.title)
    }
}

struct PreviewsIntro_Previews: PreviewProvider {
    static var previews: some View {
        PreviewsIntro()
    }
}
