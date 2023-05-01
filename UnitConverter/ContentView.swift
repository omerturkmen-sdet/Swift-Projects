//
//  ContentView.swift
//  UnitConverter
//
//  Created by ömer türkmen on 20.04.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var unit = "Temperature"
    @State private var firstUnit = "None"
    @State private var secondUnit = "None"
    @State private var input: Double = 0
    @State private var output: Double = 0
    @FocusState private var unitIsFocused: Bool
    let units = ["Temperature", "Length", "Time", "Volume"]
    let lengthUnits = ["meters", "kilometers", "feet", "yards", "miles"]
    let temperatureUnits = ["Celsius", "Fahrenheit", "Kelvin"]
    let timeUnits = ["seconds", "minutes", "hours","days"]
    let volumeUnits = ["milliliters", "liters", "cups","pints", "gallons"]
    let lengthUnitTypes = [UnitLength.meters, UnitLength.millimeters, UnitLength.kilometers, UnitLength.feet, UnitLength.yards]
    let temperatureUnitTypes = [UnitTemperature.celsius, UnitTemperature.kelvin, UnitTemperature.fahrenheit]
    
    @State private var unitArraySelection = UnitLength.meters
    
    
    var unitTypes1: [Dimension] {
        switch(unit){
        case "Length":
            return lengthUnitTypes
        default:
            return temperatureUnitTypes
        }
    }
    
    
    
    var unitTypes: [String] {
        switch(unit){
        case "Temperature":
            return temperatureUnits
        case "Length":
            return lengthUnits
        case "Time":
            return timeUnits
        case "Volume":
            return volumeUnits
        default:
            return temperatureUnits
        }
    }
    
    var convertedValue: Double{
        switch(unit){
        case "Temperature":
            return temperatureConvertedUnit
        default:
            return lengthConvertedUnit
        }
    }
    
    var lengthBaseValue: Double{
        switch(firstUnit){
        case "kilometers":
            return Measurement(value: input, unit: UnitLength.kilometers).converted(to: .meters).value
        case "feet":
            return Measurement(value: input, unit: UnitLength.feet).converted(to: .meters).value
        case "yards":
            return Measurement(value: input, unit: UnitLength.yards).converted(to: .meters).value
        case "miles":
            return Measurement(value: input, unit: UnitLength.miles).converted(to: .meters).value
        default:
            return Measurement(value: input, unit: UnitLength.meters).value
        }
    }
    
    var lengthConvertedUnit: Double{
        switch(secondUnit){
        case "kilometers":
            return Measurement(value: lengthBaseValue, unit: UnitLength.meters).converted(to: .kilometers).value
        case "feet":
            return Measurement(value: lengthBaseValue, unit: UnitLength.meters).converted(to: .feet).value
        case "yards":
            return Measurement(value: lengthBaseValue, unit: UnitLength.meters).converted(to: .yards).value
        case "miles":
            return Measurement(value: lengthBaseValue, unit: UnitLength.meters).converted(to: .miles).value
        default:
            return lengthBaseValue
        }
    }
    
    var tempertatureBaseValue: Double{
        switch(firstUnit){
        case "Fahrenheit":
            return Measurement(value: input, unit: UnitTemperature.fahrenheit).converted(to: .celsius).value
        case "Kelvin":
            return Measurement(value: input, unit: UnitTemperature.kelvin).converted(to: .celsius).value
        default:
            return Measurement(value: input, unit: UnitTemperature.celsius).value
        }
    }
    
    var temperatureConvertedUnit: Double{
        switch(secondUnit){
        case "Fahrenheit":
            return Measurement(value: tempertatureBaseValue, unit: UnitTemperature.celsius).converted(to: .fahrenheit).value
        case "Kelvin":
            return Measurement(value: tempertatureBaseValue, unit: UnitTemperature.celsius).converted(to: .kelvin).value
        default:
            return tempertatureBaseValue
        }
    }
    
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Value", value:$input, format: .number)
                        .keyboardType(.numberPad)
                        .focused($unitIsFocused)
                } header: {
                    Text("Enter value to convert")
                }
                
                Section{
                    Picker("Unit Type", selection: $unit){
                        ForEach(units, id:\.self){
                            Text($0)
                        }
                    }.pickerStyle(.menu)
                } header: {
                    Text("Select Unit type to Convert")
                }
                
                Section{
                    VStack{
                        Picker("Unit", selection: $firstUnit){
                            ForEach(unitTypes, id:\.self){
                                Text($0)
                            }
                        }
                        
                        Picker("Unit to Convert", selection: $secondUnit){
                            ForEach(unitTypes, id:\.self){
                                Text($0)
                            }
                        }
                    }
                } header: {
                    Text("Selet units for conversion")
                }
                
                Section{
                    Text(convertedValue, format: .number)
                }header: {
                    Text("Converted Unit")
                }
                
            }
            .navigationTitle("Unit Converter")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("Done"){
                        unitIsFocused = false
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



/*
 You need to build an app that handles unit conversions: users will select an input unit and an output unit, then enter a value, and see the output of the conversion.

 Which units you choose are down to you, but you could choose one of these:

 Temperature conversion: users choose Celsius, Fahrenheit, or Kelvin.
 Length conversion: users choose meters, kilometers, feet, yards, or miles.
 Time conversion: users choose seconds, minutes, hours, or days.
 Volume conversion: users choose milliliters, liters, cups, pints, or gallons.
 If you were going for length conversion you might have:

 A segmented control for meters, kilometers, feet, yard, or miles, for the input unit.
 A second segmented control for meters, kilometers, feet, yard, or miles, for the output unit.
 A text field where users enter a number.
 A text view showing the result of the conversion.
 So, if you chose meters for source unit and feet for output unit, then entered 10, you’d see 32.81 as the output.
 */
