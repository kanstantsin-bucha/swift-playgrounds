//
//  ContentView.swift
//  WeSplit
//
//  Created by Kanstantsin Bucha on 12/01/2023.
//

import SwiftUI

struct ContentView: View {
    private let users = ["Mike", "Chack", "Bob"]
    @State private var admin = "Mike"
    var body: some View {
        Form {
            Picker("admin", selection: $admin) {
                ForEach(users, id: \.self) {
                    Text("\($0)")
                }
            }
            Text("admin is \(admin)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
