//
//   TabView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 09/03/2023.
//

import SwiftUI

struct TabExampleView: View {
    @State private var selectedTab = "One"
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Image("Anime1")
                .resizable()
                .scaledToFit()
                .tabItem {
                    Label("One", systemImage: "star")
                }
                .onTapGesture {
                    selectedTab = "Two"
                }
                .tag("One")
            
            Image("Anime")
                .resizable()
                .scaledToFit()
                .tabItem {
                    Label("Two", systemImage: "circle")
                }
                .onTapGesture {
                    selectedTab = "One"
                }
                .tag("Two")
        }
    }
}

struct TabExampleView_Previews: PreviewProvider {
    static var previews: some View {
        TabExampleView()
    }
}
