//
//  Keychain.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 24/03/2025.
//

import Foundation
import KeychainSwift
class Keychain{

    let keychain = KeychainSwift()
    func setValue(data: Bool, key: String) {
        keychain.set(data, forKey: key)
    }

    func getValue(key: String) -> Bool {
        return keychain.getBool(key) ?? false
    }

    func remove(key : String){
        keychain.delete(key) // Remove single key
        keychain.clear()
    }
}
