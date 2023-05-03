//
//  SelectingDateAndTimes.swift
//  BetterRest
//
//  Created by ömer türkmen on 28.04.2023.
//

import SwiftUI

struct SelectingDateAndTimes: View {
    @State private var wakeUp = Date.now
    var body: some View {
        VStack{
            DatePicker("Please enter a date", selection: $wakeUp)
            
            /// With that it still make space
            DatePicker("", selection: $wakeUp)
            
            /// It won't display text and move picker to the middle
            DatePicker("Please enter a date", selection: $wakeUp)
                .labelsHidden()
            
            ///It only displays hour and minutes
            DatePicker("Picker only with hour and minute", selection: $wakeUp, displayedComponents: .hourAndMinute)
            
            /// It only displays date
            DatePicker("Picker only with date", selection: $wakeUp, displayedComponents: .date)
            
            /// From current date up to anything
            DatePicker("Date with range from not to infinite", selection: $wakeUp, in: Date.now...)
            
            
            DatePicker("Date with range", selection: $wakeUp, in: exampleDates())
        }
    }
    
    func exampleDates() -> ClosedRange<Date> {
        // create a second Date instance set to one day in seconds from now
        let tomorrow = Date.now.addingTimeInterval(86400)

        // create a range from those two
        let range = Date.now...tomorrow
        
        return range
    }
}

struct SelectingDateAndTimes_Previews: PreviewProvider {
    static var previews: some View {
        SelectingDateAndTimes()
    }
}
