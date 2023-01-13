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
    
    private var totalAmount: Double {
        checkAmount * (1 + Double(tipPercentage) / 100)
    }
    
    private var totalPerPerson: Double {
        totalAmount / Double(numberOfPeopleIndex + 2)
    }
    
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
                        peoplePickerView
                        .pickerStyle(.navigationLink)
                    } else {
                        peoplePickerView
                    }
                }
                Section {
                    if #available(iOS 16.0, *) {
                        tipPickerView
                        .pickerStyle(.navigationLink)
                    } else {
                        tipPickerView
                    }
                } header: {
                     Text("How much tip do you want to leave?")
                }
               
                Section {
                    Text(totalPerPerson, format: format)
                } header: {
                    Text("Amount per person:")
                }
                
                Section {
                    Text(totalAmount, format: format)
                } header: {
                    Text("Amount total:")
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
    
    var peoplePickerView: some View {
        Picker("People count", selection: $numberOfPeopleIndex) {
            ForEach(2..<26) {
                Text("\($0) People")
            }
        }
    }
    
    var tipPickerView: some View {
        Picker("Tip", selection: $tipPercentage) {
            ForEach(1..<101) {
                Text($0, format: .percent)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
