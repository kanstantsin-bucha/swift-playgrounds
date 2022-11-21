//: [Previous](@previous)

import Cocoa
import PlaygroundSupport
import Print
import SwiftUI

struct Previews_Intro: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Previews")
                .font(.largeTitle)
            Text("Introduction")
                .foregroundColor(.gray)
            Text("Xcode looks for a struct that conforms to the PreviewProvider protocol and accesses its previews property to display a view on the Canvas.")
//                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity)
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
        .frame(width: 300, height: 600)
    }
}

PlaygroundPage.current.setLiveView(Previews_Intro())

//: [Next](@next)
