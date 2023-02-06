//
//  BorderImageView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 02/02/2023.
//

import SwiftUI

struct BorderImageView: View {
    var body: some View {
        Capsule()
            .strokeBorder(ImagePaint(image: Image("Image"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5),scale: 0.3), lineWidth: 50)
            .frame(width: 300, height: 400)
        
    }
}

struct BorderImageView_Previews: PreviewProvider {
    static var previews: some View {
        BorderImageView()
    }
}
