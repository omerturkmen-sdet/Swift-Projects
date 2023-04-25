//
//  AlertMessages.swift
//  GuessTheFlag
//
//  Created by ömer türkmen on 21.04.2023.
//

import SwiftUI

struct AlertMessages: View {
    @State private var showingAlert = false
    var body: some View {
        Button ("Showing Alert"){
            showingAlert = true
        }
        .alert("Important Message", isPresented: $showingAlert){
            Button("Delete", role: .destructive){ }
            Button("Cancel", role: .cancel){ }
        } message: {
            Text("You need to consider carefully")
        }
    }
}

struct AlertMessages_Previews: PreviewProvider {
    static var previews: some View {
        AlertMessages()
    }
}
