import SwiftUI
import UIModule

public struct MainModule {
    public private(set) var text = "Hello, World!"
    
    public var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

    public init() {
    }
}
