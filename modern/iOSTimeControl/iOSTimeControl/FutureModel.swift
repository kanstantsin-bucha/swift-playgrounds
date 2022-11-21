//
//  FutureModel.swift
//  iOSTimeControl
//
//  Created by Kanstantsin Bucha on 05/11/2022.
//

import Foundation
import SwiftUI

@MainActor
class FeatureModel: ObservableObject {
    @Published var message = ""
    @Published var count = 0
    var timerTask: Task<Never, Error>?
    
    let clock: any Clock<Duration>
    
    init(
        clock: any Clock<Duration>,
        count: Int = 0
    ) {
        self.clock = clock
        self.count = count
    }
    
    func task() async {
        do {
            //      try await Task.sleep(for: .seconds(5))
            defer { UserDefaults.standard.set(true, forKey: "hasSeenViewBefore") }
            try await self.clock.sleep(
                for: UserDefaults.standard.bool(forKey: "hasSeenViewBefore") ? .seconds(1) : .seconds(5)
            )
            withAnimation {
                self.message = "Welcome!"
            }
        } catch {}
    }
    
    func startTimerButtonTapped() {
        self.timerTask = Task {
            while true {
                try await self.clock.sleep(for: .seconds(1))
                self.count += 1
            }
        }
    }
    
    func stopTimerButtonTapped() {
        self.timerTask?.cancel()
        self.timerTask = nil
    }
    
    func incrementButtonTapped() {
        self.count += 1
    }
    func decrementButtonTapped() {
        self.count -= 1
    }
    
    func nthPrimeButtonTapped() async {
        let duration = await self.clock.measure {
            var primeCount = 0
            var prime = 2
            while primeCount < self.count {
                defer { prime += 1 }
                if isPrime(prime) {
                    primeCount += 1
                } else if prime.isMultiple(of: 1_000) {
                    await Task.yield()
                }
            }
            self.message = "\(self.count)th prime is \(prime - 1)"
        }
        // TODO: track this duration with our analytics backend
        _ = duration
    }
    private func isPrime(_ p: Int) -> Bool {
        if p <= 1 { return false }
        if p <= 3 { return true }
        for i in 2...Int(sqrtf(Float(p))) {
            if p % i == 0 { return false }
        }
        return true
    }
}
