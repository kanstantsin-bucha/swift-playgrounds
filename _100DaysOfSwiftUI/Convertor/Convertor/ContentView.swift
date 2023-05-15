//
//  ContentView.swift
//  Convertor
//
//  Created by Aliaksandr Bucha on 17/01/2023.
//

import SwiftUI

enum ScaleTemperature: String {
    case celsius = "Celsius"
    case fahrenheit = "Fahrenheit"
    case kelvin = "Kelvin"
}

struct ContentView: View {
    @State private var temperatureIn = 0.0
    @State private var unitIn = ScaleTemperature.celsius.rawValue
    @State private var unitOut = ScaleTemperature.celsius.rawValue
    
    let celsius = ScaleTemperature.celsius.rawValue
    let fahrenheit = ScaleTemperature.fahrenheit.rawValue
    let kelvin = ScaleTemperature.kelvin.rawValue
    
    private var temperatureOutCelsius: Double {
        switch unitIn {
        case celsius:
            return temperatureIn
        case fahrenheit:
            return (temperatureIn - 32) * 5 / 9
        case kelvin:
            return temperatureIn - 273.15
        default:
            return 0.0
        }
    }
    
    private var temperatureOut: Double {
        switch unitOut {
        case celsius:
            return temperatureOutCelsius
        case fahrenheit:
            return temperatureOutCelsius * 9 / 5 + 32
        case kelvin:
            return temperatureIn + 273.15
        default:
            return 0.0
        }
    }
    
    private var temperatureSing: String {
        switch unitOut {
        case celsius:
            return  "\u{00B0}" + "C"
        case fahrenheit:
            return "\u{00B0}" + "F"
        case kelvin:
            return "\u{00B0}" + "K"
        default:
            return ""
        }
    }
    
    let units = [ScaleTemperature.celsius.rawValue,
                 ScaleTemperature.fahrenheit.rawValue,
                 ScaleTemperature.kelvin.rawValue]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Temperature from", selection: $unitIn) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    Picker("Temperature to", selection: $unitOut) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    TextField("temperature to convert", value: $temperatureIn, format: .number)
                }
                Section {
                    Text(String(format: "%.2f", temperatureOut) + temperatureSing)
                    
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
