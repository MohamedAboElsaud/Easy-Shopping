//
//  AccountDetailsViewModel.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 16/03/2025.
//

import SwiftUI
import CountryPicker

class AccountDetailsViewModel: ObservableObject
{
    static var shared: AccountDetailsViewModel = AccountDetailsViewModel()
    
    
    @Published var textFieldName: String = ""
    @Published var textFieldMobile: String = ""
    @Published var textFieldUsername: String = ""
    @Published var textFieldMobileCode: String = ""
    @Published var isShowPicker: Bool = false
    @Published var countryPickerObject: Country? {
        didSet {
            if( countryPickerObject != nil) {
                textFieldMobileCode = "+\(countryPickerObject!.phoneCode)"
            }
        }
    }
    
    
    @Published var textFieldCurrentPassword: String = ""
    @Published var textFieldNewPassword: String = ""
    @Published var textFieldConfirmPassword: String = ""
    
    @Published var isCurrentPassword: Bool = false
    @Published var isNewPassword: Bool = false
    @Published var isConfirmPassword: Bool = false
    
    
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    @Published var listArr: [AddressModel] = []
    
    
    init() {
        setData()
    }
    
    func clearAll(){
        textFieldName = ""
        textFieldMobile = ""
        textFieldUsername = ""
        textFieldCurrentPassword = ""
        textFieldMobileCode = ""
        textFieldNewPassword = ""
        textFieldConfirmPassword = ""
    }
    
    func setData() {
        var userObj = MainViewModel.shared.userObj
        textFieldName = userObj.name
        textFieldMobile = userObj.mobile
        textFieldMobileCode = userObj.mobileCode
        textFieldUsername = userObj.username
        
        self.countryPickerObject = Country(phoneCode: textFieldMobileCode.replacingOccurrences(of: "+", with: ""), isoCode: "EG")
    }
    
    
    
    //MARK: ServiceCall
    func serviceCallUpdate(){
        
        if(textFieldName.isEmpty) {
            self.alertMessage = "Please enter name"
            self.showAlert = true
            return
        }
        
        if(textFieldMobile.isEmpty) {
            self.alertMessage = "Please enter mobile number"
            self.showAlert = true
            return
        }
        
        if(textFieldUsername.isEmpty) {
            self.alertMessage = "Please enter username"
            self.showAlert = true
            return
        }
        
        
        
        ServiceCall.post(parameter: ["name": textFieldName, "mobile": textFieldMobile, "mobile_code": textFieldMobileCode, "username": textFieldUsername ], path: Globs.SV_UPDATE_PROFILE, isToken: true ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    
                    MainViewModel.shared.setUserData(uDict: response.value(forKey: KKey.payload) as? NSDictionary ?? [:])
                    
                    self.alertMessage = response.value(forKey: KKey.message) as? String ?? "Success"
                    self.showAlert = true
                    
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
    
    func serviceCallChangePassword(){
        
        if(textFieldCurrentPassword.isEmpty) {
            self.alertMessage = "Please enter current password"
            self.showAlert = true
            return
        }
        
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
        
        
        ServiceCall.post(parameter: ["current_password": textFieldCurrentPassword, "new_password": textFieldNewPassword], path: Globs.SV_CHANGE_PASSWORD, isToken: true ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    self.textFieldConfirmPassword = ""
                    self.textFieldNewPassword = ""
                    self.textFieldCurrentPassword = ""
                    self.alertMessage = response.value(forKey: KKey.message) as? String ?? "Success"
                    self.showAlert = true
                    
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
    
    
}
