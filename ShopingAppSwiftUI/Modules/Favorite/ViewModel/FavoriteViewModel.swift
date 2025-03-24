//
//  FavoriteViewModel.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 09/03/2025.
//

import SwiftUI

class FavoriteViewModel: ObservableObject {
    static var shared: FavoriteViewModel = .init()

    @Published var showAlert = false
    @Published var alertMessage = ""

    @Published var listArr: [ProductModel] = []

    init() {
        serviceCallList()
    }

    // MARK: ServiceCall

    func serviceCallList() {
        ServiceCall.post(parameter: [:], path: Globs.SV_FAVORITE_LIST, isToken: true) {
            [weak self] response in
            guard let self else {
                return
            }
            switch response {
            case let .success(value):
                if value.value(forKey: Key.status) as? String ?? "" == "1" {
                    self.listArr = (value.value(forKey: Key.payload) as? NSArray ?? []).map { obj in
                        ProductModel(dict: obj as? NSDictionary ?? [:])
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
