//
//  ContentView.swift
//  NewRelicIntegration
//
//  Created by Kanstantsin Bucha on 06/02/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
        .task {
            let request = URLRequest(url: URL(string: "https://tut.by")!)
            
             try? await URLSession.shared.data(for: request)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
