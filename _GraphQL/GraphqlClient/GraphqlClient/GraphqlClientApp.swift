//
//  GraphqlClientApp.swift
//  GraphqlClient
//
//  Created by Kanstantsin Bucha on 25/01/2023.
//

import SwiftUI
import GraphClientPackage

@main
struct GraphqlClientApp: App {
    
    let package = GraphClientPackage()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
