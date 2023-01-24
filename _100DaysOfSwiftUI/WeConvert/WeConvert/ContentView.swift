//
//  ContentView.swift
//  WeConvert
//
//  Created by Kanstantsin Bucha on 14/01/2023.
//

import SwiftUI

struct ContentView: View {
    private enum Unit: String {
        case celsius
        case kelvin
        case fahrenheit
    }
    private let units: [Unit] = [.celsius, .fahrenheit, .kelvin]
    @State private var unitToConvertFrom: Unit = .celsius
    @State private var unitToConvertTo: Unit = .fahrenheit
    @State private var unitFromValue = 0.0
    @FocusState var isInputFieldFocused
    
    var unitToValue: Double {
        var celsius = 0.0
        switch unitToConvertFrom {
        case .celsius:
            celsius = unitFromValue
        case .fahrenheit:
            celsius = 5 / 9 * (unitFromValue - 32)
        case .kelvin:
            celsius = unitFromValue - 273.15
        }
        
        switch unitToConvertTo {
        case .celsius:
            return celsius
        case .fahrenheit:
            return 9 / 5 * celsius + 32
        case .kelvin:
            return celsius + 273.15
        }
    }
    
    var body: some View {
        Form {
            convertingSection(
                title: "Convert from:",
                unitBinding: $unitToConvertFrom,
                valueBinding: $unitFromValue,
                inputFieldFocusBinding: $isInputFieldFocused
            )
            convertingSection(
                title: "Convert to:",
                unitBinding: $unitToConvertTo,
                value: unitToValue
            )
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    isInputFieldFocused = false
                }
            }
        }
    }
            
    private func convertingSection(
        title: String,
        unitBinding: Binding<Unit>,
        valueBinding: Binding<Double>? = nil,
        inputFieldFocusBinding: FocusState<Bool>.Binding? = nil,
        value: Double? = nil
    ) -> some View {
        Section {
            pickerView(binding: unitBinding)
            if var valueBinding, let inputFieldFocusBinding {
                TextField("Value", value: valueBinding, format: .number)
                    .keyboardType(.decimalPad)
                    .focused(inputFieldFocusBinding)
                    .onTapGesture {
                        valueBinding.wrappedValue = 0.0
                    }
            }
            if let value {
                Text("Result: \(value.formatted(.number))")
            }
        } header: {
            Text(title )
        }
    }
    
    private func pickerView(binding: Binding<Unit>) -> some View {
        Picker("Unit", selection: binding) {
            ForEach(units, id: \.self) {
                Text($0.rawValue)
            }
        }
        .pickerStyle(.segmented)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
