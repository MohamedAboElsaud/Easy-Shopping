//
//  MyOrdersViewModel.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 15/03/2025.
//

import SwiftUI

class MyOrdersViewModel: ObservableObject {
    static var shared: MyOrdersViewModel = .init()

    @Published var showAlert = false
    @Published var alertMessage = ""

    @Published var listArr: [MyOrderModel] = []

    init() {
        serviceCallList()
    }

    // MARK: ServiceCall

    func serviceCallList() {
        ServiceCall.post(parameter: [:], path: Globs.SV_MY_ORDERS_LIST, isToken: true) {
            [weak self] response in
            guard let self else {
                return
            }
            switch response {
            case let .success(value):
                if value.value(forKey: Key.status) as? String ?? "" == "1" {
                    self.listArr = (value.value(forKey: Key.payload) as? NSArray ?? []).map { obj in
                        MyOrderModel(dict: obj as? NSDictionary ?? [:])
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
}
