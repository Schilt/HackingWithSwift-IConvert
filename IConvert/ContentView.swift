//
//  ContentView.swift
//  IConvert
//      Converts temperatures between Celsius, Fahrenheit & Kelvin
//  Created by Andrew A. Schilt on 6/21/22.
//

import SwiftUI

struct ContentView: View {
    let temperatureUnits = ["Celsius", "Fahrenheit", "Kelvin"]
    @FocusState private var inputTemperatureIsFocused: Bool
    @State private var inputUnits = "Celsius"
    @State private var input = 0.0
    var inputTemp: NSMeasurement {
        get {
            switch inputUnits {
                case "Celsius" :
                    return NSMeasurement(doubleValue: input, unit: UnitTemperature.celsius)
                case "Fahrenheit" :
                    return NSMeasurement(doubleValue: input, unit: UnitTemperature.fahrenheit)
                case "Kelvin" :
                    return NSMeasurement(doubleValue: input, unit: UnitTemperature.kelvin)
            default:
                return NSMeasurement(doubleValue: 0.0, unit: UnitTemperature.kelvin)
            }
        }
    }
    
    @State private var outputUnits = "Fahrenheit"
    var outputTemp: NSMeasurement {
        get {
            switch outputUnits {
            case "Celsius" :
                return inputTemp.converting(to: UnitTemperature.celsius) as NSMeasurement
            case "Fahrenheit" :
                return inputTemp.converting(to: UnitTemperature.fahrenheit) as NSMeasurement
            case "Kelvin" :
                return inputTemp.converting(to: UnitTemperature.kelvin) as NSMeasurement
            default :
                return( NSMeasurement(doubleValue: 0, unit: UnitTemperature.kelvin))
            }
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Amount", selection: $inputUnits) {
                        ForEach(temperatureUnits, id: \.self) {
                            Text("\($0) ")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Input Temperature Units")
                }
                
                Section {
                    Picker("Amount", selection: $outputUnits) {
                        ForEach(temperatureUnits, id: \.self) {
                            Text("\($0) ")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Output Temperature Units")
                }
                
                Section {
                    TextField("InputTemperature", value: $input, format: .number )
                        .keyboardType(.decimalPad)
                        .focused($inputTemperatureIsFocused)
                    Text("Input Temperature: \(inputTemp.doubleValue.formatted()) \(inputTemp.unit.symbol)")
                    Text("Output Temperature: \(outputTemp.doubleValue.formatted()) \(outputTemp.unit.symbol)")
                }
           }
            .navigationTitle("IConvert")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        inputTemperatureIsFocused = false
                    }
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
