//
//  MainViewModel.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 15/02/2025.
//

import SwiftUI

class MainViewModel: ObservableObject {
    
    static var shared: MainViewModel = MainViewModel()
    
    @Published var textFieldUsername = ""
    @Published var textFieldEmail = ""
    @Published var textFieldPassword = ""
    @Published var isShowPassword = false
    
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    @Published var isUserLogin = false
    @Published var userObj = UserModel(dict: [:])
    
    init() {
        // spaces
        if( Utils.UDValueBool(key: Globs.userLogin) ) {
            // User Login
            self.setUserData(uDict: Utils.UDValue(key: Globs.userPayload) as? NSDictionary ?? [:] )
        }else{
            // User Not Login
        }
        
        //        #if DEBUG
        //        textFieldUsername = "user6"
        //        textFieldEmail = "test6@gmail.com"
        //        textFieldPassword = "123456"
        //
        //        #endif
    }
    
    //    MARK: Service call
    
    func logout() {
        Utils.UDSET(date: false, key: Globs.userLogin)
        isUserLogin = false
    }
    // Todo : - specific names
    func serviceCallLogin() {
        
        // Todo : divides to funcs
        if (!textFieldEmail.isValidEmail) {
            self.alertMessage = "please enter valid email address"
            self.showAlert = true
            return
            
        }
        
        
        if (textFieldPassword.isEmpty) {
            self.alertMessage = "please enter valid password"
            self.showAlert = true
            return
            
        }
        
        ServiceCall.post(parameter: ["email": textFieldEmail,"password": textFieldPassword,"dervice_token": ""], path: Globs.SV_LOGIN) { responseObj in
            if let response = responseObj as? NSDictionary{
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    self.setUserData(uDict: response.value(forKey: KKey.payload) as? NSDictionary ?? [:])
                    
                }else{
                    self.alertMessage = response.value(forKey: KKey.message) as? String ?? "Fail"
                    self.showAlert = true
                }
            }
        } failure: { error in
            self.alertMessage = error?.localizedDescription ?? "Fail"
            self.showAlert = true
        }
        
    }
    
    
    func serviceCalSignUp(){
        
        if textFieldUsername.isEmpty{
            self.alertMessage = "please enter valid username"
            self.showAlert = true
            return
            
        }
        
        if !textFieldEmail.isValidEmail{
            self.alertMessage = "please enter valid email address"
            self.showAlert = true
            return
            
        }
        
        
        if textFieldPassword.isEmpty{
            self.alertMessage = "please enter valid password"
            self.showAlert = true
            return
            
        }
        
        ServiceCall.post(parameter: ["username": textFieldUsername,"email": textFieldEmail,"password": textFieldPassword,"dervice_token": ""], path: Globs.SV_SIGN_UP) { responseObj in
            if let response = responseObj as? NSDictionary{
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    self.setUserData(uDict: response.value(forKey: KKey.payload) as? NSDictionary ?? [:])
                    
                    
                }else{
                    self.alertMessage = response.value(forKey: KKey.message) as? String ?? "Fail"
                    self.showAlert = true
                }
            }
        } failure: { error in
            self.alertMessage = error?.localizedDescription ?? "Fail"
            self.showAlert = true
        }
        
    }
    
    func setUserData(uDict: NSDictionary){
        
        Utils.UDSET(date: uDict, key: Globs.userPayload)
        Utils.UDSET(date: true, key: Globs.userLogin)
        
        self.userObj = UserModel(dict: uDict)
        self.isUserLogin = true
        self.textFieldUsername = ""
        self.textFieldEmail = ""
        self.textFieldPassword = ""
        self.isShowPassword = false
        
    }
}
