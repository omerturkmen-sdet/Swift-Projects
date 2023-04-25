//
//  GridView.swift
//  GuessTheFlag
//
//  Created by ömer türkmen on 21.04.2023.
//

import SwiftUI

struct GridView: View {
    var body: some View {
        VStack{
            HStack{
                Text("1")
                Text("0")
                Text("0")
            }
            
            HStack{
                Text("0")
                Text("1")
                Text("0")
            }
            
            HStack{
                Text("0")
                Text("0")
                Text("1")
            }
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
    }
}
