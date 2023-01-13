//
//  ContentView.swift
//  WeSplit
//
//  Created by Kanstantsin Bucha on 12/01/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var name = ""
    var body: some View {
        Form {
            TextField("name", text: $name)
            Text("My name is \(name)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
