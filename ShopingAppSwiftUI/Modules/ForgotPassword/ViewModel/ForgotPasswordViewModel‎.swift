//
//  ForgotPasswordViewModel‎.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 16/03/2025.
//

import SwiftUI

class ForgotPasswordViewModel: ObservableObject {
    static var shared: ForgotPasswordViewModel = .init()

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

    // MARK: ServiceCall

    func serviceCallRequest() {
        if !textFieldEmail.isValidEmail {
            alertMessage = "Please enter valid email address"
            showAlert = true
            return
        }

        ServiceCall.post(parameter: ["email": textFieldEmail], path: Globs.SV_FORGOT_PASSWORD_REQUEST, isToken: false) {
            [weak self] response in
            guard let self else {
                return
            }
            switch response {
            case let .success(value):
                if value.value(forKey: Key.status) as? String ?? "" == "1" {
                    self.showVerify = true
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

    func serviceCallVerify() {
        if textFieldResetCode.count != 4 {
            alertMessage = "Please enter valid otp"
            showAlert = true
            return
        }
        ServiceCall.post(parameter: ["email": textFieldEmail, "reset_code": textFieldResetCode], path: Globs.SV_FORGOT_PASSWORD_VERIFY, isToken: false) {
            [weak self] response in
            guard let self else {
                return
            }
            switch response {
            case let .success(value):
                if value.value(forKey: Key.status) as? String ?? "" == "1" {
                    self.resetObj = value.value(forKey: Key.payload) as? NSDictionary
                    self.showSetPassword = true
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

    func serviceCallSetPassword() {
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

        ServiceCall.post(parameter: ["user_id": resetObj?.value(forKey: "user_id") ?? "", "reset_code": resetObj?.value(forKey: "reset_code") ?? "", "new_password": textFieldNewPassword], path: Globs.SV_FORGOT_PASSWORD_SET_PASSWORD, isToken: false) {
            [weak self] response in
            guard let self else {
                return
            }
            switch response {
            case let .success(value):
                if value.value(forKey: Key.status) as? String ?? "" == "1" {
                    self.textFieldEmail = ""
                    self.textFieldConfirmPassword = ""
                    self.textFieldNewPassword = ""

                    self.showSetPassword = false

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
