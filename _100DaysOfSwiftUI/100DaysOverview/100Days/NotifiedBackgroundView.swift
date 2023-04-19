//
//  NotifiedBackgroundView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 18/04/2023.
//

import SwiftUI

struct NotifiedBackgroundView: View {
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .padding()
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .active {
                    print("Active")
                } else if  newPhase == . inactive {
                    print("Inactive")
                } else if newPhase == .background {
                    print("Background")
                }
            }
    }
}

struct NotifiedBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        NotifiedBackgroundView()
    }
}
