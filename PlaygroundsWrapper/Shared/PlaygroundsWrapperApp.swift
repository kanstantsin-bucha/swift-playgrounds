//
//  PlaygroundsWrapperApp.swift
//  Shared
//
//  Created by Kanstantsin Bucha on 11/12/2021.
//

import SwiftUI

struct AppState {
    @State var gradient = Gradient(colors: [
        Color(red: 1, green: 0.1, blue: 0.1),
        Color(red: 0.1, green: 0.1, blue: 1),
    ])
}

let state = AppState()

@main
struct PlaygroundsWrapperApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(gradient: state.$gradient)
        }
    }
}
