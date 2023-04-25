//
//  Buttons.swift
//  GuessTheFlag
//
//  Created by ömer türkmen on 21.04.2023.
//

import SwiftUI

struct Buttons: View {
    var body: some View {
        VStack{
            Button("Delete"){
                print("Deleting item...")
            }
            
            Button("Create", action: createUser)
            
            Button("Delete selection", role: .destructive, action: executeDelete)
        }
        
        VStack {
            Button("Button 1") { }
                .buttonStyle(.bordered).tint(.blue)
            Button("Button 2", role: .destructive) { }
                .buttonStyle(.bordered)
            Button("Button 3") { }
                .buttonStyle(.borderedProminent)
                .tint(.mint)
            Button("Button 4", role: .destructive) { }
                .buttonStyle(.borderedProminent)
            
            Button {
                print("Button was tapped")
            } label: {
                Text("Tap me!")
                    .padding(30)
                    .foregroundColor(.white)
                    .background(.red)
            }.padding(50)
        }
        
        VStack{
            HStack{
                /// It will load the same image, but won’t read it out for users who have enabled the screen reader.
                /// This is useful for images that don’t convey additional important information.
                Image(decorative: "pencil")
                
                Image(systemName: "pencil")
                Text("Hi")
                
            }
            
            Button {
                print("Edit button was tapped")
            } label: {
                Label("Edit", systemImage: "pencil")
            }
        }
    }
    
    func createUser(){
        print("Creating new user...")
    }
    
    func executeDelete(){
        print("Deleting user...")
    }
}

struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        Buttons()
    }
}
