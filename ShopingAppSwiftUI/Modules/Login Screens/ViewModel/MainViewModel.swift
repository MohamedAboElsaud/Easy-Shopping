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
        if Utils.fetchBoolValue(for: Globs.userLogin) ?? false  {
            // User Login
            self.setUserData(uDict: Utils.fetchValue(for: Globs.userPayload) as? NSDictionary ?? [:] )
        } else {
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
        Utils.setValue(with: false, for: Globs.userLogin)
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
        
        ServiceCall.post(parameter: ["email": textFieldEmail,"password": textFieldPassword,"dervice_token": ""], path: Globs.SV_LOGIN) { [weak self] response in
            guard let self else { return }
            switch response {
            case .success(let value):
                if value.value(forKey: Key.status) as? String ?? "" == "1" {
                    setUserData(uDict: value.value(forKey: Key.payload) as? NSDictionary ?? [:])
                }
            case .failure(let error):
                alertMessage = error.localizedDescription
                showAlert = true
            }
        }
    }
    
    
    func serviceCalSignUp() {

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
        
        ServiceCall.post(parameter: ["email": textFieldEmail,"password": textFieldPassword,"dervice_token": ""], path: Globs.SV_SIGN_UP) { [weak self] response in
            guard let self else { return }
            switch response {
            case .success(let value):
                if value.value(forKey: Key.status) as? String ?? "" == "1" {
                    setUserData(uDict: value.value(forKey: Key.payload) as? NSDictionary ?? [:])
                }
            case .failure(let error):
                alertMessage = error.localizedDescription
                showAlert = true
            }
        }

    }
    
    func setUserData(uDict: NSDictionary) {

        Utils.setValue(with: uDict, for: Globs.userPayload)
        Utils.setValue(with: true, for: Globs.userLogin)

        self.userObj = UserModel(dict: uDict)
        self.isUserLogin = true
        self.textFieldUsername = ""
        self.textFieldEmail = ""
        self.textFieldPassword = ""
        self.isShowPassword = false
        
    }
}
