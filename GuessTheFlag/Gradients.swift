//
//  Gradients.swift
//  GuessTheFlag
//
//  Created by ömer türkmen on 21.04.2023.
//

import SwiftUI

struct Gradients: View {
    var body: some View {
        LinearGradient(colors: [.black, .white, .blue], startPoint: .bottom, endPoint: .top)
        
        LinearGradient(gradient: Gradient(stops: [
            .init(color: .white, location: 0.2),
            .init(color: .black, location: 0.8),
        ]), startPoint: .top, endPoint: .bottom)

        RadialGradient(colors: [.blue,.yellow], center: .center, startRadius: 20, endRadius: 200)
        
        AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center)
    }
}

struct Gradients_Previews: PreviewProvider {
    static var previews: some View {
        Gradients()
    }
}
