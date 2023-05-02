//
//  Example.swift
//  RockPaperScissors
//
//  Created by ömer türkmen on 27.04.2023.
//

import SwiftUI

struct Example: View {

    @State private var options = ["🪨", "🗒","✂️"] // rock paper scissors!
    @State private var needToWin = Bool.random() // Returns true or false about whether the player needs to win
    @State private var rounds = 0 // number of game play rounds
    let computerNo = Int.random(in: 0...2) // chooses a random number between 0 and 2 that will later be the computers game move
    var toWin: String {
        if options[computerNo] == "🪨" {
            return "🗒"
        } else if options[computerNo] == "🗒" {
            return "✂️"
        } else {
            return "🪨"
        } // returns the winning answer
    }

    @State private var alertPresented = false // used to show the alert
    @State private var outcomeTitle = "" // will become the alert title
    @State private var wasCorrect = false // used to change the message in the alert
    @State private var score = 0 // tracks the score
    @State private(set) var highScore = 0 // records the high score
    @State private var hasEnded = false // used as a trigger after the last round

    var body: some View {
        ZStack{
            Color.gray
            VStack {
                Spacer()
                Text("Rock Paper Scissors")
                    .padding()
                    .scaledToFit()
                    .font(.largeTitle)
                Text("The computer chose...")
                    .padding()
                Text(options[computerNo])
                    .font(.largeTitle)
                Text("You must...")
                    .padding()
                Text(needToWin ? "Win" : "Lose")
                    .foregroundColor(needToWin ? .green : .red)
                    .padding()
                    .font(.largeTitle)
                Text("Choose wisely...")
                    .padding(30)
                HStack {
                    Spacer()
                    Button("🪨") {
                        let userOption = "🪨"
                        chosen(user: userOption)
                    } .foregroundColor(.yellow)
                        .font(.largeTitle)
                    Spacer()
                    Button("🗒") {
                        let userOption = "🗒"
                        chosen(user: userOption)
                    }.foregroundColor(.black)
                        .font(.largeTitle)
                    Spacer()
                    Button("✂️") {
                        let userOption = "✂️"
                        chosen(user: userOption)
                    } .foregroundColor(.indigo)
                        .font(.largeTitle)
                    Spacer()

                }
                Spacer()
                HStack{
                Text("Score: \(score)")
                    .padding(20)
                    VStack{
                        Text("High Score: \(highScore)")
                        Button("Reset") {
                            highScore = 0
                        }.foregroundColor(.yellow)
                    }
                }
            } .alert(outcomeTitle, isPresented: $alertPresented) {
                Button("Next", action: nextQuestion)
            } message: {
                if wasCorrect == true {
                    Text("Your score is \(score)")
                } else {
                    Text("Try again")
                }
            } .alert("Game Over", isPresented: $hasEnded) {
                Button("Restart game", action: gameOver)
            } message: {
                if wasCorrect == true {
                    Text("Correct! Your final score was \(score)")
                } else {
                    Text("Wrong! Your final score was \(score)")
                }
            }
        }
    }

    func chosen(user: String) {
        rounds += 1
        if user == toWin && needToWin == true {
            outcomeTitle = "Correct!"
            wasCorrect = true
            score += 1
        }
        if user == toWin && needToWin == false {
            outcomeTitle = "Wrong!"
            wasCorrect = false
        }
        if user != toWin && needToWin == true {
            outcomeTitle = "Wrong!"
            wasCorrect = false
        }
        if user != toWin && needToWin == false {
            outcomeTitle = "Correct!"
            wasCorrect = true
            score += 1
        }
        if rounds == 10 {
            hasEnded = true
        } else {
            alertPresented = true
        }

    }
    func nextQuestion() {
        options.shuffle()
        needToWin = Bool.random()
    }
    func gameOver() {
        nextQuestion()
        rounds = 0
        if score > highScore {
            highScore = score
        }
        score = 0
    }
}

struct Example_Previews: PreviewProvider {
    static var previews: some View {
        Example()
    }
}
