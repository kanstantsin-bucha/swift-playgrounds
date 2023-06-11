//
//  CustomTabBar.swift
//  SwiftUI1
//
//  Created by Kanstantsin Bucha on 11/06/2023.
//

import SwiftUI

enum Tabs {
    case warnings
    case weather
}

struct CustomTabBar: View {
    
    @State var tabIndex: Tabs = .warnings
    
    var body: some View {
        ZStack {
            TabView(selection: $tabIndex) {
                VStack { // Tab 1 view
                    Image(systemName: "exclamationmark.triangle.fill").font(.system(size: 80))
                }
                .tag(Tabs.warnings)
                VStack { // Tab 2 view
                    ZStack {
                        Color.red
                        VStack {
                            Image(systemName: "sun.max.fill").font(.system(size: 80))
                        }
                    }
                    .ignoresSafeArea(edges: .bottom)
                }
                .tag(Tabs.weather)
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button("Tab 1") {
                        tabIndex = .warnings
                    }
                    Spacer()
                    Button("Tab 2") {
                        tabIndex = .weather
                    }
                    Spacer()
                }
            }
        }
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar()
    }
}
