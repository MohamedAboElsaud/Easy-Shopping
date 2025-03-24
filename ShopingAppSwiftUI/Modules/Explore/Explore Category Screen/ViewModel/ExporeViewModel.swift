//
//  ExporeViewModel.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 10/03/2025.
//

import SwiftUI

class ExporeViewModel: ObservableObject {
    static var shared: ExporeViewModel = .init()

    @Published var textFieldSearch: String = ""

    @Published var showAlert = false
    @Published var alertMessage = ""

    @Published var listArr: [ExploreCategoryModel] = []

    init() {
        serviceCallList()
    }

    // MARK: ServiceCall

    func serviceCallList() {
        ServiceCall.post(parameter: [:], path: Globs.SV_EXPLORE_LIST, isToken: true) {
            [weak self] response in
            guard let self else {
                return
            }
            switch response {
            case let .success(value):
                if value.value(forKey: Key.status) as? String ?? "" == "1" {
                    self.listArr = (value.value(forKey: Key.payload) as? NSArray ?? []).map { obj in
                        ExploreCategoryModel(dict: obj as? NSDictionary ?? [:])
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
