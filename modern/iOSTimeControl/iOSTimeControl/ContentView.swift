//
//  ContentView.swift
//  iOSTimeControl
//
//  Created by Kanstantsin Bucha on 05/11/2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model: FeatureModel
    
    var body: some View {
        VStack {
            Text(model.message)
                .font(.largeTitle.bold())
                .foregroundStyle(
                    LinearGradient(
                        colors: [.mint, .yellow, .orange],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
            
            HStack {
                Button("-") { self.model.decrementButtonTapped() }
                Text("\(self.model.count)")
                Button("+") { self.model.incrementButtonTapped() }
            }
            Button("\(self.model.count)th prime") {
                Task { await self.model.nthPrimeButtonTapped() }
            }
            if self.model.timerTask == nil {
                Button("Start timer") {
                    self.model.startTimerButtonTapped()
                }
            } else {
                Button("Stop timer") {
                    self.model.stopTimerButtonTapped()
                }
            }
        }
        .task {
            await model.task()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: FeatureModel(clock: SuspendingClock()))
    }
}
