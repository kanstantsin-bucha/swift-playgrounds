//
//  iOSTimeControlApp.swift
//  iOSTimeControl
//
//  Created by Kanstantsin Bucha on 05/11/2022.
//

import SwiftUI

@main
struct iOSTimeControlApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(model: FeatureModel(clock: ImmediateClock()))
        }
    }
}
