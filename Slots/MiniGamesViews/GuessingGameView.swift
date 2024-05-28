//
//  GuessingGameView.swift
//  Slots
//
//  Created by Тимофей Юдин on 27.04.2024.
//

import SwiftUI

struct GuessingGameView: View {
    
    @State private var randomNumber = Int.random(in: 1...100)
    @State private var guess = ""
    @State private var message = ""
    @State private var isGameOver = false
    
    var body: some View {
        VStack {
            Text("Guess the number between 1 and 100")
                .padding()
            
            TextField("Enter your guess", text: $guess)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Submit") {
                checkGuess()
            }
            .padding()
            
            if isGameOver {
                Text(message)
            }
            
            Spacer()
        }
    }
    
    func checkGuess() {
        guard let number = Int(guess) else { return }
        
        if number == randomNumber {
            message = "Congratulations, you guessed the correct number!"
            isGameOver = true
        } else if number < randomNumber {
            message = "Try a higher number"
        } else {
            message = "Try a lower number"
        }
    }
}

#Preview {
    GuessingGameView()
}
