//
//  ForgotPasswordViewModel‎.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 16/03/2025.
//

import SwiftUI

class ForgotPasswordViewModel: ObservableObject
{
    static var shared: ForgotPasswordViewModel = ForgotPasswordViewModel()
    
    
    @Published var textFieldEmail: String = ""
    @Published var textFieldResetCode: String = ""
    
    @Published var textFieldNewPassword: String = ""
    @Published var textFieldConfirmPassword: String = ""
    
    @Published var isNewPassword: Bool = false
    @Published var isConfirmPassword: Bool = false
    
    @Published var showVerify: Bool = false
    @Published var showSetPassword: Bool = false
    
    @Published var showAlert = false
    @Published var alertMessage = ""
    
   
    var resetObj: NSDictionary?
    
   
    
    // TODO: implement Solid principles
    
    //MARK: ServiceCall
    func serviceCallRequest(){
        
        if(!textFieldEmail.isValidEmail) {
            self.alertMessage = "Please enter valid email address"
            self.showAlert = true
            return
        }
        
        ServiceCall.post(parameter: ["email": textFieldEmail ], path: Globs.SV_FORGOT_PASSWORD_REQUEST, isToken: false ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: Key.status) as? String ?? "" == "1" {
                    self.showVerify = true
                }else{
                    self.alertMessage = response.value(forKey: Key.message) as? String ?? "Fail"
                    self.showAlert = true
                }
            }
        } failure: { error in
            self.alertMessage = error?.localizedDescription ?? "Fail"
            self.showAlert = true
        }
    }
    
    func serviceCallVerify(){
        
        if(textFieldResetCode.count != 4) {
            self.alertMessage = "Please enter valid otp"
            self.showAlert = true
            return
        }
        ServiceCall.post(parameter: ["email": textFieldEmail, "reset_code": textFieldResetCode ], path: Globs.SV_FORGOT_PASSWORD_VERIFY, isToken: false ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: Key.status) as? String ?? "" == "1" {
                    self.resetObj = response.value(forKey: Key.payload) as? NSDictionary
                    self.showSetPassword = true
                }else{
                    self.alertMessage = response.value(forKey: Key.message) as? String ?? "Fail"
                    self.showAlert = true
                }
            }
        } failure: { error in
            self.alertMessage = error?.localizedDescription ?? "Fail"
            self.showAlert = true
        }
    }
    
    func serviceCallSetPassword(){
        
        if(textFieldNewPassword.count < 6) {
            self.alertMessage = "Please enter new password minimum 6 character"
            self.showAlert = true
            return
        }
        
        if(textFieldNewPassword != textFieldConfirmPassword) {
            self.alertMessage = "password not match"
            self.showAlert = true
            return
        }
        
        
        ServiceCall.post(parameter: ["user_id": self.resetObj?.value(forKey: "user_id") ?? "", "reset_code":self.resetObj?.value(forKey: "reset_code") ?? "" , "new_password": textFieldNewPassword], path: Globs.SV_FORGOT_PASSWORD_SET_PASSWORD, isToken: false ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: Key.status) as? String ?? "" == "1" {
                    
                    self.textFieldEmail = ""
                    self.textFieldConfirmPassword = ""
                    self.textFieldNewPassword = ""
                    
                    self.showSetPassword = false
                    
                    self.alertMessage = response.value(forKey: Key.message) as? String ?? "Success"
                    self.showAlert = true
                    
                }else{
                    self.alertMessage = response.value(forKey: Key.message) as? String ?? "Fail"
                    self.showAlert = true
                }
            }
        } failure: { error in
            self.alertMessage = error?.localizedDescription ?? "Fail"
            self.showAlert = true
        }
    }
    
    
}
