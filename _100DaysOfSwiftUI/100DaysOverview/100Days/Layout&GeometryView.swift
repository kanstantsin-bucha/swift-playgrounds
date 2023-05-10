//
//  Layout&GeometryView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 06/05/2023.
//

import SwiftUI

struct Layout_GeometryView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .frame(width: 300, height: 300)
            .background(.red)
            .padding(20)
            .background(.gray)
            .padding(20)
            
            .background(.green)
    }
}

struct Layout_GeometryView_Previews: PreviewProvider {
    static var previews: some View {
        Layout_GeometryView()
    }
}
