//
//  ObservableObjectChangesView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 09/03/2023.
//

import SwiftUI


@MainActor class DelayedUpdater: ObservableObject {
    @Published var value1 = 0
    var value2 = 10 {
        willSet {
            objectWillChange.send()
        }
    }
    
    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value1 += 1
                self.value2 -= 1
            }
        }
    }
}

struct ObservableObjectChangesView: View {
    @StateObject private var updater = DelayedUpdater()
    var body: some View {
        VStack {
            Text("value1 \(updater.value1)")
                .font(.title)
                .foregroundColor(.red)
            Text("value1 \(updater.value2)")
                .font(.title)
                .foregroundColor(.green)
        }
        
    }
}

struct ObservableObjectChangesView_Previews: PreviewProvider {
    static var previews: some View {
        ObservableObjectChangesView()
    }
}
