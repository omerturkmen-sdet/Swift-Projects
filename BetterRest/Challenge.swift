//
//  Challenge.swift
//  BetterRest
//
//  Created by ömer türkmen on 1.05.2023.
//

import CoreML
import SwiftUI

/*
 Change the user interface so that it always shows their recommended bedtime using a nice and large font. You should be able to remove the “Calculate” button entirely.
 */

struct Challenge: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var bedTime = ""


    static var defaultWakeTime: Date{
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("When do you want to wake up")
                    .font(.headline)){
                    
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }

                Section(header: Text("Desired amount of sleep")
                    .font(.headline)){
                    
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount,
                            in: 4...12, step: 0.25)
                }
                
                
                Section(header: Text("Daily coffee intake")
                    .font(.headline)){
                    
                        Picker("Coffee amount per cup", selection: $coffeeAmount){
                            ForEach(0..<20){
                                Text("\($0)")
                            }
                        }
                }
                
                Section(header: Text("Your bed time").font(.headline)){
                    Text(calculateBedTime)
                }
            }
            .padding()
            .navigationTitle("BetterRest")
            
        }
    }
    
    var calculateBedTime: String {
        do{
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour,.minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            return sleepTime.formatted(date: .omitted, time: .shortened)
            
        }catch{
            
        }
        return ""
    }
}

/*
    10:00
    8 hours
    1 cup
            --> 1:38
 
 10:00
 8 hours
 3 cup
         --> 1:10
 */

struct Challenge_Previews: PreviewProvider {
    static var previews: some View {
        Challenge()
    }
}
