//
//  BetterView.swift
//  RockPaperScissors
//
//  Created by ömer türkmen on 27.04.2023.
//

import SwiftUI

struct MoveStack: View {
    var moveName: String
    var emojiName: String
    var isHighlighted: Bool

    var body: some View {
        VStack {
            Image(systemName: "\(emojiName)")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: isHighlighted ? 60: 40)
                .padding(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                .foregroundColor(isHighlighted ? .white : .accentColor)

            Text("\(moveName)")
                .foregroundColor(isHighlighted ? .white : .accentColor)
                .font(.subheadline)
        }
    }
}

// styles the player name "Computer" or "You"
struct PlayerName: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .foregroundColor(.white)
            .padding()
        //.background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
extension View {
    func playerNameStyle() -> some View {
        modifier(PlayerName())
    }
}

struct BetterView: View {
    // store 3 possible moves for this game, along with winning moves
    let appMoves = ["Rock", "Paper", "Scissors"]
    let winningMoves = ["Paper", "Scissors", "Rock"]

    // 3 emojis that best represent rock, paper & scissors
    let emojis = ["bag", "note.text", "scissors"]

    // app shows its move, initialized to a random integer between 0 and 2
    @State private var computerMove : Int = Int.random(in: 0...2)

    // app asks player to win or lose
    @State private var shouldWin : Bool = Bool.random()

    // showingScore shows score alert. gameOver shows final score and game reset alert.
    @State private var showingScore = false
    @State private var gameOver = false

    // goes in the title of score alerts.
    @State private var scoreTitle = ""

    // keeps track of player score. Reset to 0 for new game.
    @State private var playerScore = 0

    // question counter, keep track of progress. Reset to 0 for new game.
    @State private var currentQuestion = 1

    // number of questions (or turns) to go
    let numberOfQuestions = 10

    // colorize the navigation title
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }

    var body: some View {
        NavigationView {
            ZStack {
                AngularGradient(gradient: Gradient(colors: [.black, .blue, .black, .black, .black]), center: .center)
                    .ignoresSafeArea()
                VStack {
                    HStack {
                        Spacer()
                        VStack {

                            Text("Computer")
                                .playerNameStyle()
                            ForEach(0...2, id: \.self) { i in
                                MoveStack(moveName: appMoves[i], emojiName: emojis[i], isHighlighted: i == computerMove ? true : false)
                            }

                        }
                        Spacer()
                        VStack {
                            Text(shouldWin ? "Win it" : "Lose it")
                                .font(.title.bold())
                            Text("Choose your move accordingly")
                        }
                        Spacer()
                        VStack {
                            Text("You")
                                .playerNameStyle()
                            ForEach(0...2, id: \.self) {i in
                                Button {
                                    // move was tapped
                                    moveTapped(i)
                                } label: {
                                    MoveStack(moveName: appMoves[i], emojiName: emojis[i], isHighlighted: false)
                                }

                            }

                        }
                        Spacer()

                        // score alert box
                            .alert(scoreTitle, isPresented: $showingScore) {
                                Button("Continue", action: askQuestion)
                            } message: {
                                Text("Your score is \(playerScore)")
                            }

                        // game over alert box
                            .alert("Game over", isPresented: $gameOver) {
                                Button("Reset game", action: resetGame)
                            } message: {
                                Text("Your score is \(playerScore)")
                            }
                    }
                    Spacer()
                    // score & turns
                    Text("Score: \(playerScore)").font(.title.bold())
                    Text("Turns: \(currentQuestion)/\(numberOfQuestions)")
                    // footer buttons
                    Spacer()
                }
            }

            .navigationTitle("Rock, Paper & Scissors")
            .foregroundColor(.white)

        }

    }

    // run this when player taps a move
    func moveTapped(_ number: Int) {
        var isCorrect : Bool
        // if computer is Rock, and player chose Paper, and player should win, then set isCorrect to TRUE
        switch (computerMove, number, shouldWin) {
        case (0,1, true) : isCorrect = true
        case (1,2, true) : isCorrect = true
        case (2,0, true) : isCorrect = true
        case (0,2, false) : isCorrect = true
        case (1,0, false) : isCorrect = true
        case (2,1, false) : isCorrect = true
        default : isCorrect = false
        }
        if isCorrect {
            playerScore += 1
            scoreTitle = "Correct"
        } else {
            scoreTitle = "Wrong!"
        }

        showingScore = true

        // increment the current question counter till it reaches the max number of turns / questions
        if currentQuestion < numberOfQuestions {
            currentQuestion += 1
        } else {
            gameOver = true
        }

    }

    // call the next turn
    func askQuestion() {
        shouldWin.toggle()
        computerMove = Int.random(in: 0...2)
    }

    // Game is over. Reset player's score and current question counter.
    func resetGame() {
        playerScore = 0
        currentQuestion = 1
    }
}

struct BetterView_Previews: PreviewProvider {
    static var previews: some View {
        BetterView()
    }
}
