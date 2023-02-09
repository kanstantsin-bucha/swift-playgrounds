//
//  NewRelicIntegrationApp.swift
//  NewRelicIntegration
//
//  Created by Kanstantsin Bucha on 06/02/2023.
//

import SwiftUI
import NewRelicIntegrationMain

class AppDelegate: NSObject, UIApplicationDelegate {
    let main = NewRelicIntegrationMain()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        main.startTelemetry()
        main.sendEvent()
        main.sendLog()
        main.startLogsTelemetry()
        return true
    }
}

@main
struct NewRelicIntegrationApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
