//
//  ConverterView.swift
//  UnitConverter
//
//  Created by ömer türkmen on 21.04.2023.
//

import SwiftUI

struct ConverterView: View {
    
    @State private var input = 0.0
    @FocusState private var isInputFocus: Bool
    
    @State private var selectedUnit = "Length"
    @State private var firstUnit: Dimension = UnitLength.meters
    @State private var secondUnit: Dimension = UnitLength.kilometers
    
    @State private var firstUnit1 = "None"
    @State private var secondUnit2 = "None"
    let temperatureUnits1 = ["Celsius", "Fahrenheit", "Kelvin"]
    
    
    let lengthUnits = [UnitLength.meters, UnitLength.kilometers, UnitLength.miles, UnitLength.yards, UnitLength.feet]
    let temperatureUnits = [UnitTemperature.celsius, UnitTemperature.fahrenheit, UnitTemperature.kelvin]
    let unitsPicker = ["Temperature", "Length"]
    
    @State private var enumSelect: units = .Temperature
    let unitPickEnum = [units.Temperature, units.Length]
    
    //TODO: Change strings with enum
    enum units {
        case Temperature
        case Length
        
        func tempName() -> String {
            if self == units.Length{
                return "Length"
            }
            return "Temperature"
        }
    }
    
    var selectedArrayEnum: [Dimension]{
        switch(enumSelect){
        case .Temperature:
            return temperatureUnits
        default:
            return lengthUnits
        }
    }
    
    var selectedArray: [Dimension]{
        switch(selectedUnit){
        case "Temperature":
            return temperatureUnits
        default:
             return lengthUnits
        }
    }
    
    var baseunitEnum: Dimension{
        switch(enumSelect){
        case .Temperature:
            return UnitTemperature.baseUnit()
        default:
            return UnitLength.baseUnit()
        }
    }
    
    var baseunit: Dimension{
        switch(selectedUnit){
        case "Temperature":
            return UnitTemperature.baseUnit()
        default:
            return UnitLength.baseUnit()
        }
    }
    
    var baseValueEnum: Double{
        return Measurement(value: input, unit: firstUnit).converted(to: baseunit).value
    }
    
    var convertedUnitEnum: Double{
        return Measurement(value: baseValue, unit: baseunit).converted(to: secondUnit).value
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
                }
                
                Section{
                    Picker("Unit Type", selection: $selectedUnit){
                        ForEach(unitsPicker, id: \.self){
                            Text($0)
                        }
                    }
                }header: {
                    Text("Select unit type to convert")
                }
                
                Section{
                    VStack{
                        Picker("From: ", selection: $firstUnit){
                            ForEach(selectedArray, id: \.self){
                                Text($0.symbol)
                            }
                        }
                        
                        Picker("To: ", selection: $secondUnit){
                            ForEach(selectedArray, id: \.self){
                                Text($0.symbol)
                            }
                        }
                    }
                }header: {
                    Text("Units to convert")
                }
                
                Section{
                    Picker("Enum", selection: $enumSelect){
                        ForEach(unitPickEnum, id: \.self){
                            Text($0.tempName())
                        }
                    }
                    
                    Text(enumSelect.tempName())
                }
                
                
                Section{
                    Text(convertedUnit, format: .number)
                }header: {
                    Text("Converted Value")
                }
                
            }
            .navigationTitle("Converter")
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

struct ConverterView_Previews: PreviewProvider {
    static var previews: some View {
        ConverterView()
    }
}


