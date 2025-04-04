//
//  DeliveryAddressViewModel.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 12/03/2025.
//

import SwiftUI

class DeliveryAddressViewModel: ObservableObject {
    static var shared: DeliveryAddressViewModel = .init()

    @Published var textFieldName: String = ""
    @Published var textFieldMobile: String = ""
    @Published var textFieldAddress: String = ""
    @Published var textFieldCity: String = ""
    @Published var textFieldState: String = ""
    @Published var textFieldPostalCode: String = ""
    @Published var textFieldTypeName: String = "Home"

    @Published var showAlert = false
    @Published var alertMessage = ""

    @Published var listArr: [AddressModel] = []

    init() {
        serviceCallList()
    }

    func clearAll() {
        textFieldName = ""
        textFieldMobile = ""
        textFieldAddress = ""
        textFieldCity = ""
        textFieldState = ""
        textFieldPostalCode = ""
        textFieldTypeName = "Home"
    }

    func setData(aObj: AddressModel) {
        textFieldName = aObj.name
        textFieldMobile = aObj.phone
        textFieldAddress = aObj.address
        textFieldCity = aObj.city
        textFieldState = aObj.state
        textFieldPostalCode = aObj.postalCode
        textFieldTypeName = aObj.typeName
    }

    // MARK: ServiceCall

    func serviceCallList() {
        ServiceCall.post(parameter: [:], path: Globs.SV_ADDRESS_LIST, isToken: true) {
            [weak self] response in
            guard let self else {
                return
            }
            switch response {
            case let .success(value):
                if value.value(forKey: Key.status) as? String ?? "" == "1" {
                    self.listArr = (value.value(forKey: Key.payload) as? NSArray ?? []).map { obj in
                        AddressModel(dict: obj as? NSDictionary ?? [:])
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

    func serviceCallRemove(cObj: AddressModel) {
        ServiceCall.post(parameter: ["address_id": cObj.id], path: Globs.SV_REMOVE_ADDRESS, isToken: true) {
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

    func serviceCallUpdateAddress(aObj: AddressModel?, didDone: (() -> Void)?) {
        ServiceCall.post(parameter: ["address_id": aObj?.id ?? "", "name": textFieldName, "type_name": textFieldTypeName, "phone": textFieldMobile, "address": textFieldAddress, "city": textFieldCity, "state": textFieldState, "postal_code": textFieldPostalCode], path: Globs.SV_UPDATE_ADDRESS, isToken: true) {
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

    func serviceCallAddAddress(didDone: (() -> Void)?) {
        ServiceCall.post(parameter: ["name": textFieldName, "type_name": textFieldTypeName, "phone": textFieldMobile, "address": textFieldAddress, "city": textFieldCity, "state": textFieldState, "postal_code": textFieldPostalCode], path: Globs.SV_ADD_ADDRESS, isToken: true) {
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
