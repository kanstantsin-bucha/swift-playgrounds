//
//  ContentView.swift
//  WeSplit
//
//  Created by Kanstantsin Bucha on 12/01/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 50.0
    @State private var numberOfPeopleIndex = 0
    @State private var tipPercentage = 15
    @FocusState private var isAmountFieldFocused
    
    private var format: FloatingPointFormatStyle<Double>.Currency {
        .currency(code: Locale.current.currencyCode ?? "USD")
    }
    
    private var totalPerPerson: Double {
        checkAmount * (1 + Double(tipPercentage) / 100) / Double(numberOfPeopleIndex + 2)
    }
    
    private let tipPercentages = [10, 15, 20, 25, 0]
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField(
                        "Check amount",
                        value: $checkAmount,
                        format: .number
                    )
                    .focused($isAmountFieldFocused)
                    .keyboardType(.decimalPad)
                    .onTapGesture {
                        checkAmount = 0.0
                    }
                    if #available(iOS 16.0, *) {
                        pickerView
                        .pickerStyle(.navigationLink)
                    } else {
                        pickerView
                    }
                }
                Section {
                    Picker("People count", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                     Text("How much tip do you want to leave?")
                }
               
                Section {
                    Text(totalPerPerson, format: format)
                } header: {
                    Text("Total per Person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isAmountFieldFocused = false
                    }
                }
            }
        }
    }
    
    var pickerView: some View {
        Picker("People count", selection: $numberOfPeopleIndex) {
            ForEach(2..<26) {
                Text("\($0) People")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
