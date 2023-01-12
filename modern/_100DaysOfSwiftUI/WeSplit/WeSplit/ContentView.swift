//
//  ContentView.swift
//  WeSplit
//
//  Created by Kanstantsin Bucha on 12/01/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var tapsCount = 0
    var body: some View {
        Button("Taps count \(tapsCount)") {
            tapsCount += 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
