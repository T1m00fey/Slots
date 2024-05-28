//
//  SlotsView.swift
//  Slots
//
//  Created by Тимофей Юдин on 24.04.2024.
//

import SwiftUI

struct SlotsView: View {
    @State private var slot1 = "🍎"
    @State private var slot2 = "🍌"
    @State private var slot3 = "🍉"
    @State private var bet = 0
    @State private var isAlertShowing = false
    @State private var offsetY: CGFloat = 0
    @State private var isSpinning = false
    @State private var slotTime1 = 1.0
    @State private var slotTime2 = 1.0
    @State private var slotTime3 = 1.0
    @State private var isPopoverPresenting = false
    @State private var isMiniGameShowing = false
    
    @Binding var balance: Int
    
    @Environment(\.dismiss) var dismiss
    
    private let storageManager = StorageManager.shared
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    let fruits = ["🍌", "🍓", "🍒"]
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    HStack {
                        ZStack {
                            slotView
                            
                            Text(slot1)
                                .font(.system(size: 70))
                                .offset(y: offsetY)
                        }
                        
                        ZStack {
                            Text(slot2)
                                .font(.system(size: 70))
                                .offset(y: offsetY)
                            
                            slotView
                        }
                        
                        ZStack {
                            slotView
                            
                            Text(slot3)
                                .font(.system(size: 70))
                                .offset(y: offsetY)
                        }
                    }
//                    .onReceive(timer) { _ in
//                        if isSpinning {
//                            withAnimation(Animation.linear(duration: 0.1)) {
//                                offsetY -= 50
//                            }
//                        }
//                        
//                        if offsetY <= -150 {
//                            isSpinning = false
//                            offsetY = 0
//                            
//                            slot1 = fruits.randomElement() ?? "🍎"
//                            slot2 = fruits.randomElement() ?? "🍌"
//                            slot3 = fruits.randomElement() ?? "🍉"
//                            
//                            if slot1 == slot2 && slot1 == slot3 {
//                                withAnimation {
//                                    balance += bet * 3
//                                }
//                                
//                                isWin = true
//                                isAlertShowing.toggle()
//                            } else {
//                                withAnimation {
//                                    balance -= bet
//                                }
//                            }
//                        }
//                    }
                    .onReceive(timer, perform: { _ in
                        if isSpinning {
                            if slotTime1 > 0 {
                                withAnimation {
                                    slot1 = fruits.randomElement() ?? "🍎"
                                    slot2 = fruits.randomElement() ?? "🍌"
                                    slot3 = fruits.randomElement() ?? "🍉"
                                    
                                    slotTime1 -= 0.1
                                }
                            } else if slotTime2 > 0 {
                                withAnimation {
                                    slot2 = fruits.randomElement() ?? "🍌"
                                    slot3 = fruits.randomElement() ?? "🍉"
                                    
                                    slotTime2 -= 0.1
                                }
                            } else if slotTime3 > 0 {
                                withAnimation {
                                    slot3 = fruits.randomElement() ?? "🍉"
                                    
                                    slotTime3 -= 0.1
                                }
                            } else {
                                isSpinning.toggle()
                                
                                slotTime1 = 1.0
                                slotTime2 = 1.0
                                slotTime3 = 1.0
                                
                                if slot1 == slot2 && slot1 == slot3 {
//                                    withAnimation {
//                                        balance += bet * 3
//                                    }
                                    isAlertShowing.toggle()
                                } else {
                                    withAnimation {
                                        balance -= bet
                                        
                                        if balance <= 0 {
                                            isPopoverPresenting.toggle()
                                        }
                                    }
                                }
                                
                                if bet > balance {
                                    bet = balance
                                }
                            }
                        }
                    })
                    .frame(width: UIScreen.main.bounds.width - 32)
                    .padding()
                    
                    HStack {
                        Text("\(bet)")
                            .font(.title)
                        
                        Spacer()
                        
                        Stepper("") {
                            bet += 500
                            
                            if bet > balance {
                                bet = balance
                            }
                        } onDecrement: {
                            bet -= 500
                            
                            if bet < 0 {
                                bet = 0
                            }
                        }
                        
                    }
                    .frame(width: UIScreen.main.bounds.width - 32)
                    .padding()
                    
                    Button {
                        if balance <= 0 {
                            isPopoverPresenting.toggle()
                        } else {
                            isSpinning = true
                        }
                    } label: {
                        Text("SPIN")
                            .font(.largeTitle)
                            .foregroundStyle(Color(uiColor: .label))
                            .frame(width: UIScreen.main.bounds.width - 32, height: 55)
                            .background(Color(uiColor: .systemBackground))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(uiColor: .label), lineWidth: 4)
                            )
                            .padding()
                    }
                    .popover(isPresented: $isAlertShowing, content: {
                        ResultOfGameView(isPresenting: $isAlertShowing, balance: $balance, prize: bet * 3)
                            .presentationDetents([.medium])
                    })
                }
                .padding()
                .navigationBarBackButtonHidden()
                .onChange(of: isAlertShowing, { oldValue, newValue in
                    if !newValue {
                        storageManager.set(balance: balance)
                    }
                })
                .navigationTitle("💰 \(balance) 💰")
                .onDisappear {
                    storageManager.set(balance: balance)
                }
                .popover(isPresented: $isPopoverPresenting, content: {
                    MiniGameOfferView(isPresenting: $isPopoverPresenting, isMiniGameViewShowing: $isMiniGameShowing)
                        .presentationDetents([.medium])
                })
                .sheet(isPresented: $isMiniGameShowing, content: {
                    MiniGameView(isPresenting: $isMiniGameShowing, balance: $balance)
                })
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "arrow.backward")
                                .foregroundStyle(Color(uiColor: .label))
                        }
                    }
                }
            }
        }
    }
}

private extension SlotsView {
    var slotView: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 100, height: 100)
            .foregroundStyle(Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(uiColor: .label), lineWidth: 3)
            )
            .padding()
    }
}

#Preview {
    SlotsView(balance: .constant(10000))
}
