//
//  ExploreItemViewModel.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 10/03/2025.
//

import Foundation

class ExploreItemViewModel: ObservableObject {
    @Published var cObj: ExploreCategoryModel = .init(dict: [:])
    @Published var showAlert = false
    @Published var alertMessage = ""

    @Published var listArr: [ProductModel] = []

    init(catObj: ExploreCategoryModel) {
        cObj = catObj
        serviceCallList()
    }

    // MARK: ServiceCall

    func serviceCallList() {
        ServiceCall.post(parameter: ["cat_id": cObj.id], path: Globs.SV_EXPLORE_ITEMS_LIST, isToken: true) {
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
