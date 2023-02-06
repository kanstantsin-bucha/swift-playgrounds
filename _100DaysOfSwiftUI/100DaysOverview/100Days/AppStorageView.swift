//
//  AppStorageView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 27/01/2023.
//

import SwiftUI

struct AppStorageView: View {
    @AppStorage("TapCount") private var tapCount = 0
    var body: some View {
        Button("Was tapped \(tapCount)") {
            tapCount += 1
        }
    }
}

struct AppStorageView_Previews: PreviewProvider {
    static var previews: some View {
        AppStorageView()
    }
}
