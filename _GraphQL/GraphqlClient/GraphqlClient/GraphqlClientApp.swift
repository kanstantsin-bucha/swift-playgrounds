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
                .task {
                    do {
                        let users = try await package.fetchAllUsers()
                        let user = try await package.fetchUserBy(id: users[2].id)
                        print(user)
                    } catch {
                        print(error)
                    }
                }
        }
    }
}
