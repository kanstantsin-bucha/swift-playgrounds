//
//  SwiftUI1App.swift
//  SwiftUI1
//
//  Created by Kanstantsin Bucha on 24/01/2023.
//

import SwiftUI

@main
struct SwiftUI1App: App {
    var body: some Scene {
        WindowGroup {
            content
        }
    }
    
    var content: some View {
        return NavigationView {
            Form {
                Section {
                    NavigationLink("Previews Intro") {
                        PreviewsIntro()
                    }
                    NavigationLink("Parent Child Data Flow") {
                        ParentChildDataFlow()
                    }
                    //            GeometryReaderV()
                    //            BottomSheetSizedToFitView()
                    //            if #available(iOS 16, *) {
                    //                ValueNavigationInNavigationStack()
                    //            }
                    //            DestinationInNavigationView()
                    //            composeMainNavigationView()
                    //            LifeView()
                    //            SunflowerPatternView()
                    //            OtherRoot()
                }
                Section("Chat GPT") {
                    NavigationLink("Card View") {
                        CardView()
                    }
                    NavigationLink("Sunflower View") {
                        SunflowerPatternView()
                    }
                    NavigationLink("Life View") {
                        LifeView()
                    }
                }
                Section("Metal") {
                    if #available(iOS 17, *) {
                        NavigationLink("Shader Transition View") {
                            ShaderTransitionView()
                        }
                    }
                }
            }
        }
    }
}
