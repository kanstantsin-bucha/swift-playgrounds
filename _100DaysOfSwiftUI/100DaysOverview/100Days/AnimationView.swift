//
//  AnimationView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 25/01/2023.
//

import SwiftUI

struct AnimationView: View {
    @State private var isEnabled = false
    
    let gradientRed = Gradient(colors: [.red, .black])
    let gradientBlue = Gradient(colors: [.blue, .black])
    
    var body: some View {
        ZStack {
            Color(.gray)
                .ignoresSafeArea()
            VStack {
                Spacer()
                
                Button("Tap Me") {
                    isEnabled.toggle()
                }
                .frame(width: 200, height: 200)
                .background(isEnabled ? gradientRed : gradientBlue)
                .animation(.default, value: isEnabled)
                
                .foregroundColor(.white)
                .cornerRadius(isEnabled ? 200 : 50)
                .shadow(radius: 30)
                .animation(.interpolatingSpring(stiffness: 10, damping: 1), value: isEnabled)
               
                Spacer()
            }
        }
    }
}

struct AnimationView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationView()
    }
}
