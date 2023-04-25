//
//  Challenge.swift
//  GuessTheFlag
//
//  Created by ömer türkmen on 22.04.2023.
//

import SwiftUI

struct Challenge: View {
    @State private var score = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var selectedAnswer = 0
    @State private var guessCount = 0
    @State private var gameOver = false
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack{
                Spacer()
                
                Text("Guess The Flag")
                    .font(.largeTitle).bold()
                    .foregroundColor(.white)
                
                VStack(spacing: 15){
                    VStack{
                        Text("Tap the flag of")
                            .foregroundColor(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3){ number in
                        Button{
                            flagTapped(number)
                        }label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                VStack{
                    Text("Score: \(score)")
                        .font(.largeTitle.bold()).foregroundColor(.white)
                    
                    Text("Remaining Guess: \(8 - guessCount)")
                        .font(.body).fontWeight(.light).foregroundColor(.white)
                }
                
                Spacer()
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
        if number == correctAnswer{
            scoreTitle = "Correct"
            score += 1
        }else{
            scoreTitle = "Wrong"
            guessCount += 1
        }
        
        if guessCount == 8{
            gameOver = true
        }
        selectedAnswer = number
        showingScore = true
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func reset() {
        score = 0
        guessCount = 0
        askQuestion()
    }
    
}

struct Challenge_Previews: PreviewProvider {
    static var previews: some View {
        Challenge()
    }
}
