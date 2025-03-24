//
//  HomeViewModel.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 19/02/2025.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    static var shared: HomeViewModel = .init()

//        @Published var selectTab: Int = 0
    @Published var textFieldSearch: String = ""

    @Published var showAlert = false
    @Published var alertMessage = ""

    @Published var offerArr: [ProductModel] = []
    @Published var bestArr: [ProductModel] = []
    @Published var listArr: [ProductModel] = []
    @Published var typeArr: [TypeModel] = []

    init() {
        serviceCallList()
    }

    // MARK: ServiceCall

    func serviceCallList() {
        ServiceCall.post(parameter: [:], path: Globs.SV_HOME, isToken: true) {
            [weak self] response in
            guard let self else {
                return
            }
            switch response {
            case let .success(value):
                if value.value(forKey: Key.status) as? String ?? "" == "1" {
                    if let payloadObj = value.value(forKey: Key.payload) as? NSDictionary {
                        self.offerArr = (payloadObj.value(forKey: "offer_list") as? NSArray ?? []).map { obj in

                            ProductModel(dict: obj as? NSDictionary ?? [:])
                        }

                        self.bestArr = (payloadObj.value(forKey: "best_sell_list") as? NSArray ?? []).map { obj in

                            ProductModel(dict: obj as? NSDictionary ?? [:])
                        }

                        self.listArr = (payloadObj.value(forKey: "list") as? NSArray ?? []).map { obj in

                            ProductModel(dict: obj as? NSDictionary ?? [:])
                        }

                        self.typeArr = (payloadObj.value(forKey: "type_list") as? NSArray ?? []).map { obj in

                            TypeModel(dict: obj as? NSDictionary ?? [:])
                        }
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
