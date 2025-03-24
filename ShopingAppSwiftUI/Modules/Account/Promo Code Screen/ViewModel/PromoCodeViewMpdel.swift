//
//  PromoCodeViewMpdel.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 13/03/2025.
//

import SwiftUI

class PromoCodeViewModel: ObservableObject {
    // MARK: Lifecycle

    init() {
        serviceCallList()
    }

    // MARK: Internal

    static var shared: PromoCodeViewModel = .init()

    @Published var showAlert = false
    @Published var alertMessage = ""

    @Published var listArr: [PromoCodeModel] = []

    // MARK: ServiceCall

    func serviceCallList() {
        ServiceCall.post(parameter: [:], path: Globs.SV_PROMO_CODE_LIST, isToken: true) {
            [weak self] response in
            guard let self else {
                return
            }
            switch response {
            case let .success(value):
                if value.value(forKey: Key.status) as? String ?? "" == "1" {
                    self.listArr = (value.value(forKey: Key.payload) as? NSArray ?? []).map { obj in
                        PromoCodeModel(dict: obj as? NSDictionary ?? [:])
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
