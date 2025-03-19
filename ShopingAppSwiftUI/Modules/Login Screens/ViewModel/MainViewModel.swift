//
//  MainViewModel.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 15/02/2025.
//

import SwiftUI

class MainViewModel: ObservableObject {
        
    static var shared: MainViewModel = MainViewModel()
    
    @Published var txtUsername = ""
    @Published var txtEmail = ""
    @Published var txtPassword = ""
    @Published var isShowPassword = false
    
    @Published var showError = false
    @Published var errorMessage = ""
    
    @Published var isUserLogin = false
    @Published var userObj = UserModel(dict: [:])
    
    init() {
        // spaces
        if (Utils.UDValueBool(key: Globs.userLogin)) {
            self.setUserData(uDict: Utils.UDValue(key: Globs.userPayload) as? NSDictionary ?? [:])
        } else {
            
        }
        
        #if DEBUG
        txtUsername = "user6"
        txtEmail = "test6@gmail.com"
        txtPassword = "123456"
        
        #endif
    }
    
//    MARK: Service call
    
    func logout() {
        Utils.UDSET(date: false, key: Globs.userLogin)
        isUserLogin = false
    }
// Todo : - specific names
    func serviceCallLogin() {
        
        // Todo : divides to funcs
        if !txtEmail.isValidEmail {
            self.errorMessage = "please enter valid email address"
            self.showError = true
            return
            
        }

        
        if txtPassword.isEmpty {
            self.errorMessage = "please enter valid password"
            self.showError = true
            return
            
        }
        
        ServiceCall.post(parameter: ["email": txtEmail,"password": txtPassword,"dervice_token": ""], path: Globs.SV_LOGIN) { responseObj in
            if let response = responseObj as? NSDictionary{
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {

                    self.setUserData(uDict: response.value(forKey: KKey.payload) as? NSDictionary ?? [:])

                }else{
                    self.errorMessage = response.value(forKey: KKey.message) as? String ?? "Fail"
                    self.showError = true
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? "Fail"
            self.showError = true
        }

    }
    
    
    func serviceCalSignUp(){
        
        if txtUsername.isEmpty{
            self.errorMessage = "please enter valid username"
            self.showError = true
            return
            
        }
        
        if !txtEmail.isValidEmail{
            self.errorMessage = "please enter valid email address"
            self.showError = true
            return
            
        }

        
        if txtPassword.isEmpty{
            self.errorMessage = "please enter valid password"
            self.showError = true
            return
            
        }
        
        ServiceCall.post(parameter: ["username": txtUsername,"email": txtEmail,"password": txtPassword,"dervice_token": ""], path: Globs.SV_LOGIN) { responseObj in
            if let response = responseObj as? NSDictionary{
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {

                    self.setUserData(uDict: response.value(forKey: KKey.payload) as? NSDictionary ?? [:])
                  
                    
                }else{
                    self.errorMessage = response.value(forKey: KKey.message) as? String ?? "Fail"
                    self.showError = true
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? "Fail"
            self.showError = true
        }

    }
    
    func setUserData(uDict: NSDictionary){
        
        Utils.UDSET(date: uDict, key: Globs.userPayload)
        Utils.UDSET(date: true, key: Globs.userLogin)

        self.userObj = UserModel(dict: uDict)
        self.isUserLogin = true
        self.txtUsername = ""
        self.txtEmail = ""
        self.txtPassword = ""
        self.isShowPassword = false
    
    }
}
