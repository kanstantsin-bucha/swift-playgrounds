//
//  ContentView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 18/01/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showAlert = false
    var body: some View {
        Button("Show Alert", role: .cancel, action: buttonTaped)
            .buttonStyle(.borderedProminent)
            .tint(.mint)
            .alert("Important message", isPresented: $showAlert) {
                Button("Ok") {}
            }
    }
    
    func buttonTaped() {
        showAlert = true
        print("Button taped")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
