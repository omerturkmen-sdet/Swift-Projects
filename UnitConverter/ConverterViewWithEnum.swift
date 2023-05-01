//
//  ConverterViewWithEnum.swift
//  UnitConverter
//
//  Created by ömer türkmen on 21.04.2023.
//

import SwiftUI

struct ConverterViewWithEnum: View {
    
    @FocusState private var isInputFocus: Bool
    @State private var input = 0.0
    @State private var selectedUnitType: Units = .temperature
    @State private var firstUnit: Dimension = UnitTemperature.celsius
    @State private var secondUnit: Dimension = UnitTemperature.celsius
    
    enum Units {
    case temperature, length
        func getName() -> String {
            if self == .temperature{
                return "Temperature"
            }
            return "Length"
        }
    }
    
    let units: [Units] = [.temperature, .length]
    let temperatureUnits = [UnitTemperature.celsius, UnitTemperature.fahrenheit, UnitTemperature.kelvin]
    let lengthUnits = [UnitLength.meters, UnitLength.kilometers, UnitLength.yards]
    
    
    var selectedUnit: [Dimension]{
        switch(selectedUnitType){
        case .temperature:
            return temperatureUnits
        default:
            return lengthUnits
        }
    }
    
    var baseunit: Dimension{
        switch(selectedUnitType){
        case .temperature:
            return UnitTemperature.baseUnit()
        default:
            return UnitLength.baseUnit()
        }
    }

    var baseValue: Double{
        return Measurement(value: input, unit: firstUnit).converted(to: baseunit).value
    }
    
    var convertedUnit: Double{
        return Measurement(value: baseValue, unit: baseunit).converted(to: secondUnit).value
    }

    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Input", value: $input, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isInputFocus)
                }header: {
                    Text("Enter value to convert")
                }
                
                Section{
                    Picker("Unit Type", selection: $selectedUnitType){
                        ForEach(units, id: \.self){
                            Text($0.getName())
                        }
                    }
                }header: {
                    Text("Select Unit Type")
                }
                
                Section{
                    Picker("From: ", selection: $firstUnit){
                        ForEach(selectedUnit, id: \.self){
                            Text($0.symbol)
                        }
                    }
                    Picker("To: ", selection: $secondUnit){
                        ForEach(selectedUnit, id: \.self){
                            Text($0.symbol)
                        }
                    }
                }header: {
                    Text("Select conversion types")
                }
                
                Section{
                    Text(convertedUnit, format: .number)
                }header: {
                    Text("Converted Value")
                }
            }
            .navigationTitle("Converter with enum")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("Done"){
                        isInputFocus = false
                    }
                }
            }
        }
    }
}

struct ConverterViewWithEnum_Previews: PreviewProvider {
    static var previews: some View {
        ConverterViewWithEnum()
    }
}
