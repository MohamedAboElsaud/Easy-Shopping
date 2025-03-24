//
//  PaymentViewModel.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 14/03/2025.
//
//

import SwiftUI

class PaymentViewModel: ObservableObject {
    static var shared: PaymentViewModel = .init()

    @Published var textFieldName: String = ""
    @Published var textFieldCardNumber: String = ""
    @Published var textFieldCardMonth: String = ""
    @Published var textFieldCardYear: String = ""

    @Published var showAlert = false
    @Published var alertMessage = ""

    @Published var listArr: [PaymentModel] = []

    init() {
        serviceCallList()
    }

    func clearAll() {
        textFieldName = ""
        textFieldCardNumber = ""
        textFieldCardYear = ""
        textFieldCardMonth = ""
    }

    // MARK: ServiceCall

    func serviceCallList() {
        ServiceCall.post(parameter: [:], path: Globs.SV_PAYMENT_METHOD_LIST, isToken: true) {
            [weak self] response in
            guard let self else {
                return
            }
            switch response {
            case let .success(value):
                if value.value(forKey: Key.status) as? String ?? "" == "1" {
                    self.listArr = (value.value(forKey: Key.payload) as? NSArray ?? []).map { obj in
                        PaymentModel(dict: obj as? NSDictionary ?? [:])
                    }
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

    func serviceCallRemove(pObj: PaymentModel) {
        ServiceCall.post(parameter: ["pay_id": pObj.id], path: Globs.SV_REMOVE_PAYMENT_METHOD, isToken: true) {
            [weak self] response in
            guard let self else {
                return
            }
            switch response {
            case let .success(value):
                if value.value(forKey: Key.status) as? String ?? "" == "1" {
                    self.serviceCallList()
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

    func serviceCallAdd(didDone: (() -> Void)?) {
        if textFieldName.isEmpty {
            alertMessage = "please enter name"
            showAlert = true
            return
        }

        if textFieldCardNumber.count != 16 {
            alertMessage = "please enter valid card number"
            showAlert = true
            return
        }

        if textFieldCardMonth.count != 2 {
            alertMessage = "please enter valid card month"
            showAlert = true
            return
        }

        if textFieldCardYear.count != 4 {
            alertMessage = "please enter valid card year"
            showAlert = true
            return
        }

        ServiceCall.post(parameter: ["name": textFieldName, "card_number": textFieldCardNumber, "card_month": textFieldCardMonth, "card_year": textFieldCardYear], path: Globs.SV_ADD_PAYMENT_METHOD, isToken: true) {
            [weak self] response in
            guard let self else {
                return
            }
            switch response {
            case let .success(value):
                if value.value(forKey: Key.status) as? String ?? "" == "1" {
                    self.clearAll()
                    self.serviceCallList()
                    didDone?()
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
