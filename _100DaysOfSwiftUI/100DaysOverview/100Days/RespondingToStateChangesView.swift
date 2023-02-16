//
//  RespondingToStateChangesView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 16/02/2023.
//

import SwiftUI

struct RespondingToStateChangesView: View {
    @State private var blurAmount = 0.0
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .blur(radius: blurAmount)
            Slider(value: $blurAmount, in: 0...20)
            
            Button("Random Blur") {
                blurAmount = Double.random(in: 0...20)
            }
        }
        .onChange(of: blurAmount) { newValue in
            print(newValue)
        }
    }
}

struct RespondingToStateChangesView_Previews: PreviewProvider {
    static var previews: some View {
        RespondingToStateChangesView()
    }
}
