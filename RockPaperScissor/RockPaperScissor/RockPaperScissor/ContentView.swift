//
//  ContentView.swift
//  RockPaperScissor
//
//  Created by Christopher Smith on 2/15/25.
//

import SwiftUI

struct ContentView: View {
    let moves = ["🪨", "📜", "✂️"]
    let winners = ["📜", "✂️", "🪨"]
    
    @State private var opponent = "🪨"
    @State private var playerShouldWin = true
    @State private var playerScore = 0
    @State private var decision = ""
    @State private var showingDecision = false
    @State private var totalRounds = 10
    @State private var gameOver = false
    
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            Spacer()
            
            Text("Player Score: \(playerScore)")
                .font(.largeTitle.bold())
            
            Text("Opponent throws \(opponent)")
                .font(.title.weight(.semibold))
            
            Text("Pick the winner: \(playerShouldWin)")
                .font(.title.weight(.semibold))
            
            Spacer()
            
            ForEach(0..<3) { pick in
                Button {
                    playerPick(moves[pick])
                } label: {
                    Text(moves[pick])
                }
            }
            .font(.largeTitle)
            .padding()
            
            Spacer()
            Spacer()
            Spacer()
        }
        .alert(decision, isPresented: $showingDecision) {
            Button("Continue", action: playGame)
        }
        .alert("Game Over", isPresented: $gameOver) {
            Button("Restart", action: reset)
            //Button("Cancel", role: .cancel) {}
        } message: {
            Text("Your final score is \(playerScore)")
        }
    }
    
    func playGame() {
        guard totalRounds > 0 else {
            gameOver = true
            return
        }
        opponent = moves[Int.random(in: 0..<moves.count)]
        playerShouldWin = Bool.random()
    }
    
    func playerPick(_ pick: String) {
        if pick == "🪨" {
            if playerShouldWin == true {
                if opponent == "✂️" {
                    playerScore += 1
                    decision = "You Win"
                } else {
                    playerScore -= 1
                    decision = "You Lose"
                }
            } else {
                if opponent == "📜" {
                    playerScore += 1
                    decision = "You Win"
                } else {
                    playerScore -= 1
                    decision = "You Lose"
                }
            }
        }
        if pick == "📜" {
            if playerShouldWin == true {
                if opponent == "🪨" {
                    playerScore += 1
                    decision = "You Win"
                } else {
                    playerScore -= 1
                    decision = "You Lose"
                }
            } else {
                if opponent == "✂️" {
                    playerScore += 1
                    decision = "You Win"
                } else {
                    playerScore -= 1
                    decision = "You Lose"
                }
            }
        }
        if pick == "✂️" {
            if playerShouldWin == true {
                if opponent == "📜" {
                    playerScore += 1
                    decision = "You Win"
                } else {
                    playerScore -= 1
                    decision = "You Lose"
                }
            } else {
                if opponent == "🪨" {
                    playerScore += 1
                    decision = "You Win"
                } else {
                    playerScore -= 1
                    decision = "You Lose"
                }
            }
        }
        
        showingDecision = true
        
        totalRounds -= 1
    }
    
    func reset() {
        playerScore = 0
        totalRounds = 10
    }
}


#Preview {
    ContentView()
}
