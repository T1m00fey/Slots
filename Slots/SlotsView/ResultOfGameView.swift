//
//  ResultOfGameView.swift
//  Slots
//
//  Created by Тимофей Юдин on 27.04.2024.
//

import SwiftUI

struct ResultOfGameView: View {
    @Binding var isPresenting: Bool
    @Binding var balance: Int
    
    let prize: Int
    
    var body: some View {
        ZStack {
            Rain(character: "💸")
            
            VStack {
                Text("You won \(prize)")
                    .font(.largeTitle)
                
                Button {
                    isPresenting.toggle()
                    
                    withAnimation {
                        balance += prize
                    }
                } label: {
                    Text("Get it! 🤑")
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
}

#Preview {
    ResultOfGameView(isPresenting: .constant(true), balance: .constant(10000), prize: 1000)
}
