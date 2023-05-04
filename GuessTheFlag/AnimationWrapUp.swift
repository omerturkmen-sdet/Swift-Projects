//
//  AnimationWrapUp.swift
//  GuessTheFlag
//
//  Created by ömer türkmen on 4.05.2023.
//

import SwiftUI

struct AnimationWrapUp: View {
    
    @State private var score = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var selectedAnswer = 0
    @State private var guessCount = 0
    @State private var gameOver = false
    
    @State private var isCorrect = false
    @State private var selectedNumber = 0
    @State private var isFadeOutOpacity = false
    @State private var isWrong = false
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            
            VStack{
                Text("Guess The Flag")
                    .font(.largeTitle)
                    .fontWeight(.heavy)

                VStack (spacing: 15) {
                    VStack{
                        Text("Tap the Flag of")
                            .foregroundColor(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.heavy))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            withAnimation {
                                flagTapped(number)
                            }
                            
                        }label: {
                            Image(countries[number])
                                .flagStyle()
                        }
                        .rotation3DEffect(.degrees(isCorrect && selectedNumber == number  ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                        .opacity(isFadeOutOpacity && selectedNumber != number ? 0.25 : 1)
                        .rotation3DEffect(.degrees(isWrong && selectedNumber == number ? 360 : 0), axis: (x: 0, y: 0, z: 0.5))
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                VStack {
                    Text("Score \(score)")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                    
                    Text("Remaining Guess: \(8 - guessCount)")
                        .font(.body)
                        .fontWeight(.light)
                        .foregroundColor(.white)
                }
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
        }message: {
            if scoreTitle == "Correct"{
                Text("congratulations!")
            }else{
                Text("Wrong! That's the flag of \(countries[selectedAnswer])")
            }
        }
        
        .alert("Game Over!", isPresented: $gameOver){
            Button("Reset Game", action: reset)
        }
    }
    
    func flagTapped(_ number: Int){
        selectedNumber = number
        if number == correctAnswer{
            scoreTitle = "Correct"
            score += 1
            isCorrect = true
            isFadeOutOpacity = true
        }else{
            scoreTitle = "Wrong"
            guessCount += 1
            isWrong = true
            isFadeOutOpacity = true
        }
        
        if guessCount == 8{
            gameOver = true
        }
        selectedAnswer = number
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            showingScore = true
        }
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        isCorrect = false
        isFadeOutOpacity = false
        isWrong = false
    }
    
    func reset() {
        score = 0
        guessCount = 0
        askQuestion()
    }
}

struct AnimationWrapUp_Previews: PreviewProvider {
    static var previews: some View {
        AnimationWrapUp()
    }
}
