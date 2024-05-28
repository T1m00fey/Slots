//
//  MiniGameOfferView.swift
//  Slots
//
//  Created by Тимофей Юдин on 26.04.2024.
//

import SwiftUI

struct MiniGameOfferView: View {
    @Binding var isPresenting: Bool
    @Binding var isMiniGameViewShowing: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("It looks like you've run out of money...")
                    .font(.title)
                    .multilineTextAlignment(.center)
                
                Button {
                    isMiniGameViewShowing.toggle()
                } label: {
                    Text("Earn money 🤑")
                        .font(.title)
                        .foregroundStyle(Color(uiColor: .label))
                        .frame(width: UIScreen.main.bounds.width - 100, height: 50)
                        .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(uiColor: .label), lineWidth: 2)
                            )
                        .padding()
                }
                
                Button {
                    isPresenting.toggle()
                } label: {
                    Text("No, thanks")
                        .underline()
                        .font(.title3)
                }
                .foregroundStyle(Color(uiColor: .label))
            }
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

#Preview {
    MiniGameOfferView(isPresenting: .constant(true), isMiniGameViewShowing: .constant(false))
}
