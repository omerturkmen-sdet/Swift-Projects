//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by ömer türkmen on 26.04.2023.
//

import SwiftUI

struct Rock: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
    }
}

extension View{
    func rockStyle() -> some View{
        modifier(Rock())
    }
}


struct ContentView: View {
    @State private var options = ["Rock","Paper","Scissors"]
    @State private var optionsImages = ["hand.thumbsup","hand.thumbsdown","return"]
    @State private var winOrLose = ["Win","Lose"]
    @State private var answer = ""
    @State private var randomOption = Int.random(in: 0...2)
    @State private var randomChoice = Int.random(in: 0...1)
    @State private var color = Color.red
    let rock = (win: "Scissors", lose: "Paper")
    let paper = (win: "Rock", lose: "Scissors")
    let scissors = (win: "Paper", lose: "Rock")
    var body: some View {
        ZStack{
            VStack {
                let option = options[randomOption]
                let gameStatus = winOrLose[randomChoice]
                
                Spacer()
                Spacer()
                
                Text(option)
                    .rockStyle()
                
                Text(gameStatus)
                
                Spacer()
                
                Picker("Select correct answer", selection: $answer){
                    ForEach(options, id: \.self){
                        Text($0)
                        Image(systemName: $0)
                        
                    }
                }
                .pickerStyle(.segmented)
                .frame(width: .infinity)
               
                
                
                let isAnswerCorrect = answer == getCorrectAnswer()
                
                

                Spacer()
                Spacer()
                
                isAnswerCorrect ? Image(systemName: "hand.thumbsup") : Image(systemName: "hand.thumbsdown")
                


                
                
            }
            .padding()
        }
    }
    
    func getTuple() -> (win: String, lose: String) {
        switch(options[randomOption]){
        case "Rock":
            return rock
        case "Paper":
            return paper
        default:
            return scissors
        }
    }
    
    func getCorrectAnswer() -> String{
        winOrLose[randomChoice] == "Win" ? getTuple().win :
                        getTuple().lose
    }
    
    func getImage(){
        Image(systemName: "retur")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
