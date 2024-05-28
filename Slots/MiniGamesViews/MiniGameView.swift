//
//  MiniGameView.swift
//  Slots
//
//  Created by Тимофей Юдин on 27.04.2024.
//

import SwiftUI

struct MiniGameView: View {
    @State private var isGameView = false
    @State private var isGameStarted = false
    @State private var timerRemained = 10
    @State private var count = 0
    @State private var isGameEnded = false
    @State private var isWin = false
    
    @Binding var isPresenting: Bool
    @Binding var balance: Int
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationStack {
            ZStack {
                if isWin {
                    Rain(character: "💸")
                }
                
                VStack {
                    if !isGameView && !isGameEnded {
                        Spacer()
                        
                        Text("To earn an additional 5,000, you need to click on the coin more than 50 times in 10 seconds")
                            .font(.title2)
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        Spacer()
                        
                        Button {
                            isGameView = true
                        } label: {
                            Text("EARN MONEY 🤑")
                                .font(.title)
                                .foregroundStyle(Color(uiColor: .label))
                                .frame(width: UIScreen.main.bounds.width - 60, height: 55)
                                .background(Color(uiColor: .systemBackground))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(uiColor: .label), lineWidth: 2)
                                )
                                .padding()
                        }
                        
                        Spacer()
                    } else if isGameView {
                        Text("\(timerRemained)")
                            .font(.title)
                        
                        Text("\(count)")
                            .font(.title2)
                            .padding()
                        
                        Spacer()
                        
                        Button {
                            if isGameStarted {
                                count += 1
                            }
                        } label: {
                            Text("💰")
                                .font(.system(size: 150))
                        }
                        
                        Spacer()
                        
                        if !isGameStarted {
                            Button {
                                isGameStarted = true
                            } label: {
                                Text("💸 START 💸")
                                    .font(.title)
                                    .foregroundStyle(Color(uiColor: .label))
                                    .frame(width: UIScreen.main.bounds.width - 60, height: 55)
                                    .background(Color(uiColor: .systemBackground))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color(uiColor: .label), lineWidth: 2)
                                    )
                                    .padding()
                            }
                        }
                    } else if isGameEnded {
                        if isWin {
                            Text("You won 5,000 🤑")
                                .font(.largeTitle)
                                .multilineTextAlignment(.center)
                            
                            Button {
                                isPresenting.toggle()
                                
                                balance += 5000
                            } label: {
                                Text("💸 Great! 💸")
                                    .font(.title)
                                    .foregroundStyle(Color(uiColor: .label))
                                    .frame(width: UIScreen.main.bounds.width - 60, height: 55)
                                    .background(Color(uiColor: .systemBackground))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color(uiColor: .label), lineWidth: 2)
                                    )
                                    .padding()
                            }
                        } else {
                            Text("You've lost!")
                                .font(.largeTitle)
                                .multilineTextAlignment(.center)
                            
                            Button {
                                isGameView = false
                                isGameEnded = false
                                isGameStarted = false
                                
                                timerRemained = 10
                            } label: {
                                Text("Try again!")
                                    .font(.title)
                                    .foregroundStyle(Color(uiColor: .label))
                                    .frame(width: UIScreen.main.bounds.width - 60, height: 55)
                                    .background(Color(uiColor: .systemBackground))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color(uiColor: .label), lineWidth: 2)
                                    )
                                    .padding()
                            }
                        }
                    }
                }
                .onReceive(timer, perform: { _ in
                    if isGameStarted && timerRemained > 0 {
                        timerRemained -= 1
                        print(timerRemained)
                    } else if isGameStarted && timerRemained == 0 {
                        if count >= 50 {
                            isWin = true
                        }
                        
                        print("123")
                        
                        isGameStarted = false
                        isGameView = false
                        isGameEnded = true
                    }
                })
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            isPresenting.toggle()
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(Color(uiColor: .systemGray3))
                                .font(.title2)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    MiniGameView(isPresenting: .constant(true), balance: .constant(10000))
}
