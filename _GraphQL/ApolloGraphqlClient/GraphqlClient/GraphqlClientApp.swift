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
                        let taskID = try await package.createTask(
                            input: CreateTaskInput(
                                name: "Home Work",
                                completed: false,
                                userId: user.id
                            )
                        )
                        let task = try await package.fetchTaskBy(id: taskID)
                        print(task)
                        _ = try await package.createTask(
                            input: CreateTaskInput(
                                name: "Wash Dishes",
                                completed: false,
                                userId: user.id
                            )
                        )
                        _ = try await package.createTask(
                            input: CreateTaskInput(
                                name: "Play With Friends",
                                completed: true,
                                userId: user.id
                            )
                        )
                        
                        let (userA, tasksA) = try await package.fetchUserWithTasksBy(id: user.id)
                        print(userA, tasksA)
                    } catch {
                        print(error)
                    }
                }
        }
    }
}
