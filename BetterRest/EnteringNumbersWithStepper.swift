//
//  EnteringNumbersWithStepper.swift
//  BetterRest
//
//  Created by ömer türkmen on 28.04.2023.
//

import SwiftUI

struct EnteringNumbersWithStepper: View {
    @State private var sleepAmount = 8.0
    var body: some View {
        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
    }
}

struct EnteringNumbersWithStepper_Previews: PreviewProvider {
    static var previews: some View {
        EnteringNumbersWithStepper()
    }
}
