//
//  CustomComponentWith@BindingView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 09/02/2023.
//

import SwiftUI

struct PushButton: View {
    let title: String
    @Binding var isOn: Bool
    
    var onColors = [Color.red, Color.yellow]
    var ofColors = [Color(white: 0.6), Color(white: 0.4)]
    
    var body: some View {
        Button(title) {
            isOn.toggle()
        }
        .padding()
        .background(LinearGradient(colors: isOn ? onColors : ofColors, startPoint: .top, endPoint: .bottom))
        .foregroundColor(.white)
        .clipShape(Capsule())
        .shadow(radius: isOn ? 0 : 5)
    }
}

struct CustomComponentWith_BindingView: View {
    @State private var rememberMe = false
    var body: some View {
        VStack {
            PushButton(title: "Remember Me", isOn: $rememberMe)
            Text( rememberMe ? "On" : "Off")
        }
    }
}

struct CustomComponentWith_BindingView_Previews: PreviewProvider {
    static var previews: some View {
        CustomComponentWith_BindingView()
    }
}
