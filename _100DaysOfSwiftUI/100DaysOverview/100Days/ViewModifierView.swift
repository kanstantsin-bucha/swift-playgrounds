//
//  SecondView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 19/01/2023.
//

import SwiftUI

struct WaterMark: ViewModifier {
    var text: String
    func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(.mint)
        }
    }
}

extension View {
    func waterMark(_ text: String) -> some View {
        modifier(WaterMark(text: text))
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 200, height: 200)
            .font(.largeTitle.weight(.semibold))
            .foregroundColor(.blue)
            .background(.gray)
    }
}

extension View {
    func titleStyle() -> some View {
        return modifier(Title())
    }
}

struct SecondView: View {
    var body: some View {
        VStack {
           Text("Large blue Title ")
            .titleStyle()
            
            Color.blue
                .frame(width: 300, height: 300)
                .waterMark("Some")
        }
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}
