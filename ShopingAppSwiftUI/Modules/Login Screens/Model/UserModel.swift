//
//  UserModel.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 17/02/2025.
//

import SwiftUI

struct UserModel: Identifiable,Equatable {
    
    var id: Int = 0
    var username = ""
    var name = ""
    var email = ""
    var mobile = ""
    var mobileCode = ""
    var authToken = ""
    
    init(dict: NSDictionary) {
        self.id = dict.value(forKey: "user_id") as? Int ?? 0
        self.username = dict.value(forKey: "username") as? String ?? ""
        self.name = dict.value(forKey: "name") as? String ?? ""
        self.email = dict.value(forKey: "email") as? String ?? ""
        self.mobile = dict.value(forKey: "mobile") as? String ?? ""
        self.mobileCode = dict.value(forKey: "mobile_code") as? String ?? ""
        self.authToken = dict.value(forKey: "auth_token") as? String ?? ""
    }
    
    static func == (lhs:UserModel,rhs:UserModel) ->Bool {
        return lhs.id == rhs.id
        
    }
}
