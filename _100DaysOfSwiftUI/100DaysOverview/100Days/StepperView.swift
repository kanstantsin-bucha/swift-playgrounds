//
//  StepperView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 23/01/2023.
//

import SwiftUI

struct StepperView: View {
    @State private var sleepAmount = 8.0
    var body: some View {
        Stepper("Sleep \(sleepAmount.formatted()) hour", value: $sleepAmount, in: 4...12, step: 0.25)
    }
}

struct StepperView_Previews: PreviewProvider {
    static var previews: some View {
        StepperView()
    }
}
