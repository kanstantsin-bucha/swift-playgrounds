//
//  UsingTimerView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 18/04/2023.
//

import SwiftUI

struct UsingTimerView: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var counter = 0
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onReceive(timer) { time in
                if counter == 5 {
                    timer.upstream.connect().cancel()
                    print("The time is over")
                } else {
                    print("The timer is now \(time)")
                }
                counter += 1
            }
    }
}

struct UsingTimerView_Previews: PreviewProvider {
    static var previews: some View {
        UsingTimerView()
    }
}
