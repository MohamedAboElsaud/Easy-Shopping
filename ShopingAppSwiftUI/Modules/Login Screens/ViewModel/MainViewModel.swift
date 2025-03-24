//
//  MainViewModel.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 15/02/2025.
//

import SwiftUI

class MainViewModel: ObservableObject {
    // MARK: Lifecycle

    init() {
        // spaces
        if Keychain().getValue(key: Globs.userLogin) {
            // User Login
            setUserData(uDict: UserDefault.getValue(key: Globs.userPayload) as? NSDictionary ?? [:])
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

    // MARK: Internal

    static var shared: MainViewModel = .init()

    @Published var textFieldUsername = ""
    @Published var textFieldEmail = ""
    @Published var textFieldPassword = ""
    @Published var isShowPassword = false

    @Published var showAlert = false
    @Published var alertMessage = ""

    @Published var isUserLogin = false
    @Published var userObj: UserModel = .init(dict: [:])

    //    MARK: Service call

    func logout() {
        // UserDefault.UDSET(date: false, key: Globs.userLogin)
        Keychain().remove(key: Globs.userLogin)
        UserDefault.remove(key: Globs.userPayload)
        isUserLogin = false
    }

    // TODO: - specific names
    func serviceCallLogin() {
        // TODO: divides to funcs
        if !textFieldEmail.isValidEmail {
            alertMessage = "please enter valid email address"
            showAlert = true
            return
        }

        if textFieldPassword.isEmpty {
            alertMessage = "please enter valid password"
            showAlert = true
            return
        }

        ServiceCall.post(parameter: ["email": textFieldEmail, "password": textFieldPassword, "dervice_token": ""], path: Globs.SV_LOGIN) {
            [weak self] response in
            guard let self else {
                return
            }
            switch response {
            case let .success(value):
                if value.value(forKey: Key.status) as? String ?? "" == "1" {
                    self.setUserData(uDict: value.value(forKey: Key.payload) as? NSDictionary ?? [:])

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

    func serviceCalSignUp() {
        if textFieldUsername.isEmpty {
            alertMessage = "please enter valid username"
            showAlert = true
            return
        }

        if !textFieldEmail.isValidEmail {
            alertMessage = "please enter valid email address"
            showAlert = true
            return
        }

        if textFieldPassword.isEmpty {
            alertMessage = "please enter valid password"
            showAlert = true
            return
        }

        ServiceCall.post(parameter: ["username": textFieldUsername, "email": textFieldEmail, "password": textFieldPassword, "dervice_token": ""], path: Globs.SV_SIGN_UP) {
            [weak self] response in
            guard let self else {
                return
            }
            switch response {
            case let .success(value):
                if value.value(forKey: Key.status) as? String ?? "" == "1" {
                    self.setUserData(uDict: value.value(forKey: Key.payload) as? NSDictionary ?? [:])

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

    func setUserData(uDict: NSDictionary) {
        UserDefault.setValue(date: uDict, key: Globs.userPayload)
        Keychain().setValue(data: true, key: Globs.userLogin)

        userObj = UserModel(dict: uDict)
        isUserLogin = true
        textFieldUsername = ""
        textFieldEmail = ""
        textFieldPassword = ""
        isShowPassword = false
    }
}
