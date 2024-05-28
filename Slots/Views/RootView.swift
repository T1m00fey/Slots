//
//  RootView.swift
//  Slots
//
//  Created by Тимофей Юдин on 24.04.2024.
//

import SwiftUI

struct RootView: View {
    @State private var balance = 0
    
    private let storageManager = StorageManager.shared
    
    var body: some View {
        NavigationStack {
            ZStack {
                Rain(character: "💸")
                
                VStack {
                    NavigationLink {
                        SlotsView(balance: $balance)
//                        SlotMachineAnimation()
                    } label: {
                        Text("PLAY")
                            .font(.largeTitle)
                            .foregroundStyle(Color(uiColor: .label))
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color(uiColor: .systemBackground))
                            .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(uiColor: .label), lineWidth: 4)
                                )
                            .padding()
                    }
                }
            }
            .navigationTitle("💰 \(balance) 💰")
        }
        .onAppear {
            if !storageManager.isFirst() {
                storageManager.set(balance: 10000)
                
                balance = 10000
                
                storageManager.setIsFirst(true)
            } else {
                balance = storageManager.fetchBalance()
            }
        }
    }
}

#Preview {
    RootView()
}
