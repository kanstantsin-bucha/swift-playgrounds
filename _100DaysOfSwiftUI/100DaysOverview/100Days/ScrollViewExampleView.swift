//
//  ScrollView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 30/01/2023.
//

import SwiftUI

struct CustomText: View {
    let text: String
 
    var body: some View {
        Text(text)
    }
    init(_ text: String) {
        print(" Create a new CustomText")
        self.text = text
    }
}

struct ScrollViewExampleView: View {
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                ForEach(0..<510) {
                    CustomText("Hello,\($0)!")
                }
            }
//  this property don't need  if use LazyVStack 
//            .frame(maxWidth: .infinity)
        }
    }
}

struct ScrollView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewExampleView()
    }
}
