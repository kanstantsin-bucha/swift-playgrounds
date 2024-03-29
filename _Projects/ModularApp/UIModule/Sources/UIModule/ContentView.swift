//
//  ContentView.swift
//  ModularApp
//
//  Created by Kanstantsin Bucha on 16/12/2022.
//

import SwiftUI

public struct ContentView: View {
    
    public init() {}
    
    public var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
