//
//  MyDetailsViewModel.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 16/03/2025.
//

import CountryPicker
import SwiftUI

class AccountDetailsViewModel: ObservableObject {
    static var shared: AccountDetailsViewModel = .init()

    @Published var textFieldName: String = ""
    @Published var textFieldMobile: String = ""
    @Published var textFieldUsername: String = ""
    @Published var textFieldMobileCode: String = ""
    @Published var isShowPicker: Bool = false
    @Published var countryPickerObject: Country? {
        didSet {
            if countryPickerObject != nil {
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

    func clearAll() {
        textFieldName = ""
        textFieldMobile = ""
        textFieldUsername = ""
        textFieldCurrentPassword = ""
        textFieldMobileCode = ""
        textFieldNewPassword = ""
        textFieldConfirmPassword = ""
    }

    func setData() {
        let userObj = MainViewModel.shared.userObj
        textFieldName = userObj.name
        textFieldMobile = userObj.mobile
        textFieldMobileCode = userObj.mobileCode
        textFieldUsername = userObj.username

        countryPickerObject = Country(phoneCode: textFieldMobileCode.replacingOccurrences(of: "+", with: ""), isoCode: "EG")
    }

    // MARK: ServiceCall

    func serviceCallUpdate() {
        if textFieldName.isEmpty {
            alertMessage = "Please enter name"
            showAlert = true
            return
        }

        if textFieldMobile.isEmpty {
            alertMessage = "Please enter mobile number"
            showAlert = true
            return
        }

        if textFieldUsername.isEmpty {
            alertMessage = "Please enter username"
            showAlert = true
            return
        }

        ServiceCall.post(parameter: ["name": textFieldName, "mobile": textFieldMobile, "mobile_code": textFieldMobileCode, "username": textFieldUsername], path: Globs.SV_UPDATE_PROFILE, isToken: true) {
            [weak self] response in
            guard let self else {
                return
            }
            switch response {
            case let .success(value):
                if value.value(forKey: Key.status) as? String ?? "" == "1" {
                    MainViewModel.shared.setUserData(uDict: value.value(forKey: Key.payload) as? NSDictionary ?? [:])
                    self.alertMessage = value.value(forKey: Key.message) as? String ?? "Success"
                    self.showAlert = true

                } else {
                    self.alertMessage = value.value(forKey: Key.message) as? String ?? "Fail"
                    self.showAlert = true
                }
            case let .failure(error):
                alertMessage = error.localizedDescription
                showAlert = true
            }
        }
    }

    func serviceCallChangePassword() {
        if textFieldCurrentPassword.isEmpty {
            alertMessage = "Please enter current password"
            showAlert = true
            return
        }

        if textFieldNewPassword.count < 6 {
            alertMessage = "Please enter new password minimum 6 character"
            showAlert = true
            return
        }

        if textFieldNewPassword != textFieldConfirmPassword {
            alertMessage = "password not match"
            showAlert = true
            return
        }

        ServiceCall.post(parameter: ["current_password": textFieldCurrentPassword, "new_password": textFieldNewPassword], path: Globs.SV_CHANGE_PASSWORD, isToken: true) {
            [weak self] response in
            guard let self else {
                return
            }
            switch response {
            case let .success(value):
                if value.value(forKey: Key.status) as? String ?? "" == "1" {
                    self.textFieldConfirmPassword = ""
                    self.textFieldNewPassword = ""
                    self.textFieldCurrentPassword = ""
                    self.alertMessage = value.value(forKey: Key.message) as? String ?? "Success"
                    self.showAlert = true

                } else {
                    self.alertMessage = value.value(forKey: Key.message) as? String ?? "Fail"
                    self.showAlert = true
                }
            case let .failure(error):
                alertMessage = error.localizedDescription
                showAlert = true
            }
        }
    }
}
