//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Christopher Smith on 2/8/25.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var playerScore = 0
    @State private var gameOver = false
    @State private var totalRounds = 0
    
    @State private var selectedFlag = 3
    @State private var xRotation = [0.0, 0.0, 0.0]
    @State private var yRotation = [0.0, 0.0, 0.0]
    @State private var opaque = [1.0, 1.0, 1.0]
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                VStack (spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            animate(number)
                            flagTapped(number)
                            
                            withAnimation {
                                yRotation[number] += 3600
                            }
                            
                            for i in 0..<3 {
                                if i != number {
                                    withAnimation {
                                        xRotation[i] += 45
                                        opaque[i] -= 0.75
                                    }
                                }
                            }
                            
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                                .rotation3DEffect(.degrees(yRotation[number]), axis: (x: 0, y: 1, z: 0))
                                .rotation3DEffect(.degrees(xRotation[number]), axis: (x: 1, y: 0, z: 0))
                                .opacity(opaque[number])
                        }
                        
                    }
                    
                    
                    Button("Restart") {
                        gameOver = true
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(playerScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: askQuestion)
            } message: {
                Text("Your score is \(playerScore)")
            }
            .alert("Game Over", isPresented: $gameOver) {
                // Need to fix so that it answers correct before going to game over
                Button("Restart", action: reset)
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Your final score is \(playerScore)")
            }
    }
    
    func animate(_ number: Int) {
        selectedFlag = number
    }
    
    func flagTapped(_ number: Int) {
        if totalRounds == (2) {
            gameOver = true //Need to fix so it triggers without having to answer extra question 
        } else {
            if number == correctAnswer {
                scoreTitle = "Correct"
                playerScore += 1
            } else {
                scoreTitle = """
            Wrong 
            That is the flag of \(countries[number])
            """
            }
            
            totalRounds += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                showingScore = true
            }
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        selectedFlag = 3
        xRotation = [0.0, 0.0, 0.0]
        yRotation = [0.0, 0.0, 0.0]
        opaque = [1.0, 1.0, 1.0]
    }
    
    func reset() {
            scoreTitle = "You have finished all 8 guesses"
            playerScore = 0
            totalRounds = 0
            countries.shuffle()
        }

}

#Preview {
    ContentView()
}
