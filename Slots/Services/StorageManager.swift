//
//  StorageManager.swift
//  Slots
//
//  Created by Тимофей Юдин on 24.04.2024.
//

import Foundation

final class StorageManager {
    static let shared = StorageManager()
    private init() {}
    
    private let userDefaults = UserDefaults.standard
    private let key = "balance"
    
    func fetchBalance() -> Int {
        return userDefaults.integer(forKey: key)
    }
    
    func set(balance: Int) {
        userDefaults.setValue(balance, forKey: key)
    }
    
    func isFirst() -> Bool {
        return userDefaults.bool(forKey: "isFirst")
    }
    
    func setIsFirst(_ isFirst: Bool) {
        userDefaults.setValue(isFirst, forKey: "isFirst")
    }
}
