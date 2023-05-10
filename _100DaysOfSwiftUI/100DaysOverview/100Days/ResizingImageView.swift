//
//  ResizingImageView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 30/01/2023.
//

import SwiftUI

struct ResizingImageView: View {
    var body: some View {
        VStack {
            Image("Image")
                .frame(width: 300, height: 300)
                .clipped()
            
            GeometryReader { geo in
                Image("Image")
                    .resizable()
                    .scaledToFit()
//                    .frame(width: geo.size.height)
                    .frame(width: geo.size.width, height: geo.size.height)
            }
            
                
        }
    }
}

struct ResizingImageView_Previews: PreviewProvider {
    static var previews: some View {
        ResizingImageView()
    }
}
