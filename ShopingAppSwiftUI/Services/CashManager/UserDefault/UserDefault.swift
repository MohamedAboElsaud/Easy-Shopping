//
//  UserDefault.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 24/03/2025.
//

import Foundation

class UserDefault {
    class func setValue(date: Any, key: String) {
        UserDefaults.standard.set(date, forKey: key)
        UserDefaults.standard.synchronize()
    }

    class func getValue(key: String) -> Any {
        return UserDefaults.standard.value(forKey: key) as Any
    }

    class func getValueBool(key: String) -> Bool {
        return UserDefaults.standard.value(forKey: key) as? Bool ?? false
    }

    class func remove(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
