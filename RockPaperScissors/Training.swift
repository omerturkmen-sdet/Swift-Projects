//
//  Training.swift
//  RockPaperScissors
//
//  Created by ömer türkmen on 26.04.2023.
//

import SwiftUI



struct Training: View {
    
    @State private var options = ["🪨", "🗒","✂️"]
    @State private var needToWin = Bool.random()
    @State private var randomOption = Int.random(in: 0...2)
    @State private var score: Int = 0
    @State private var selection = ""
    @State private var isAlertPresented = false
    @State private var gameOver = false
    @State private var rounds = 0
    @State private var alertTitle = ""
    @State private var wasCorrect = false
    
    let rock = (win: "🗒", lose: "✂️")
    let paper = (win: "✂️", lose: "🪨")
    let scissors = (win: "🪨", lose: "🗒")
    
    var body: some View {
        ZStack{
            Color.orange.ignoresSafeArea()
            
            
            VStack{
                Spacer()
                Text("Rock Paper Scissors")
                    .font(.largeTitle).fontWeight(.heavy)
                let option = options[randomOption]
                
                Spacer()
                Spacer()
                
                Text(option).font(.largeTitle)
                
                Spacer()
                
                Text(needToWin ? "You need to win" : "You need to lose")
                    .font(.title)
                    .foregroundColor(needToWin ? .green : .red)
                
                Spacer()
                HStack(spacing: 80){
                    Button("🪨"){
                        setScore(answer: "🪨")
                    }
                    
                    Button("✂️"){
                        setScore(answer: "✂️")
                    }
                    
                    Button("🗒"){
                        setScore(answer: "🗒")
                    }
                }
                .font(.largeTitle)
                
                Text("Score is \(score)")
                
            }
            .alert(alertTitle, isPresented: $isAlertPresented){
                Button("Next", action: nextRound)
            }message: {
                alertTitle == "Correct" ?
                Text("Your score is: \(score)") :
                Text("Try again")
            }
            .alert("Game Over", isPresented: $gameOver){
                Button("Restart Game", action: reset)
            }message: {
                alertTitle == "Correct" ?
                Text("Correct! Your final score is \(score)") :
                Text("Wrong! Your final score is \(score)")
            }
        }
    }
    
    func getTuple() -> (win: String, lose: String)? {
        let selected = options[randomOption]
        switch(selected){
        case "🪨":
            return rock
        case "🗒":
            return paper
        case "✂️":
            return scissors
        default:
            return nil
        }
    }

    func getCorrectAnswer() -> String?{
        needToWin ? getTuple()?.win :
                        getTuple()?.lose
    }
    
    func setScore(answer: String){
        rounds += 1
        let correctAnswer = getCorrectAnswer()
        if correctAnswer == answer {
            alertTitle = "Correct"
            score += 1
        }else{
            alertTitle = "Wrong!"
        }
        
        if rounds == 10{
            gameOver = true
        }else{
            isAlertPresented = true
        }
    }
    
    func nextRound(){
        options.shuffle()
        needToWin = Bool.random()
    }
    
    func reset(){
        nextRound()
        rounds = 0
        score = 0
    }
}

struct Training_Previews: PreviewProvider {
    static var previews: some View {
        Training()
    }
}
