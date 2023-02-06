//
//  UserDefaultView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 27/01/2023.
//

import SwiftUI

struct UserDefaultView: View {
    @State private var tapCount = UserDefaults.standard.integer(forKey: "TapCount")
    var body: some View {
        Button("Was tapped \(tapCount)") {
            tapCount += 1
            UserDefaults.standard.set(tapCount, forKey: "TapCount")
        }
    }
}

struct UserDefaultView_Previews: PreviewProvider {
    static var previews: some View {
        UserDefaultView()
    }
}
