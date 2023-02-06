//
//  ShowingAndHidingView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 25/01/2023.
//

import SwiftUI

struct ShowingAndHidingView: View {
    @State private var isShowing = false
    var body: some View {
        VStack {
            Button("Tap Me") {
                withAnimation {
                    isShowing.toggle()
                }
            }
            if isShowing {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
        }
    }
}

struct ShowingAndHidingView_Previews: PreviewProvider {
    static var previews: some View {
        ShowingAndHidingView()
    }
}
