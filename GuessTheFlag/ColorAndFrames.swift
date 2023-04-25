//
//  ColorAndFrames.swift
//  GuessTheFlag
//
//  Created by ömer türkmen on 21.04.2023.
//

import SwiftUI

struct ColorAndFrames: View {
    var body: some View {
        ZStack{
            Color(red: 1, green: 0.8, blue: 0)
                .ignoresSafeArea()
            Color.red
                .frame(minWidth: 200, maxWidth: .infinity, maxHeight: 200)
            
            Text("ZStack Content")
                .foregroundColor(.white)
        }
        
        ZStack {
            VStack(spacing: 0) {
                Color.red
                Color.blue
            }

            Text("Your content")
                .foregroundStyle(.secondary)
//                .foregroundColor(.secondary)
                .padding(50)
                .background(.ultraThinMaterial)
        }
        .ignoresSafeArea()
    }
}

struct ColorAndFrames_Previews: PreviewProvider {
    static var previews: some View {
        ColorAndFrames()
    }
}


// Color.primary
///Color.primary is the default color of text in SwiftUI, and will be either black or white depending on whether the user’s device is running in light mode or dark mode.
///
///Color.secondary, which is also black or white depending on the device, but now has slight transparency so that a little of the color behind it shines through.

// ignoresSafeArea()
/// If we want to go under safe area (go edge to edge) we can use this. Otherwise it will not effect safe areas
/// Safe areas: both the status bar (the clock area at the top) and the home indicator (the horizontal stripe at the bottom)
