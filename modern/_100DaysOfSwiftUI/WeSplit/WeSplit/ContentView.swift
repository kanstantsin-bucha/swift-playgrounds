//
//  ContentView.swift
//  WeSplit
//
//  Created by Kanstantsin Bucha on 12/01/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 10.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    private var format: FloatingPointFormatStyle<Double>.Currency {
        .currency(code: Locale.current.currencyCode ?? "USD")
    }
    
    private let tipPercentages = [10, 15, 20, 25, 0]
    var body: some View {
        Form {
            Section {
                TextField(
                    "Check amount",
                    value: $checkAmount,
                    format: .number
                )
                .keyboardType(.decimalPad)
                .onTapGesture {
                    checkAmount = 0.0
                }
            }
            Section {
                Text(checkAmount, format: format)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
