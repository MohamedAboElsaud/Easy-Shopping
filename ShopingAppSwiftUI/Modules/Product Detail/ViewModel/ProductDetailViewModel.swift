//
//  ProductDetailViewModel.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 22/02/2025.
//

import SwiftUI

class ProductDetailViewModel: ObservableObject {
    @Published var pObj: ProductModel = .init(dict: [:])
    @Published var showAlert = false
    @Published var alertMessage = ""

    @Published var nutritionArr: [NutritionModel] = []
    @Published var imageArr: [ImageModel] = []

    @Published var isFav: Bool = false
    @Published var isShowDetail: Bool = false
    @Published var isShowNutrition: Bool = false
    @Published var qty: Int = 1

    func showDetail() {
        isShowDetail = !isShowDetail
    }

    func showNutrition() {
        isShowNutrition = !isShowNutrition
    }

    func addSubQTY(isAdd: Bool = true) {
        if isAdd {
            qty += 1
            if qty > 99 {
                qty = 99
            }
        } else {
            qty -= 1
            if qty < 1 {
                qty = 1
            }
        }
    }

    init(prodObj: ProductModel) {
        pObj = prodObj
        isFav = prodObj.isFav
        serviceCallDetail()
    }

    // MARK: ServiceCall

    func serviceCallDetail() {
        ServiceCall.post(parameter: ["prod_id": pObj.prodId], path: Globs.SV_PRODUCT_DETAIL, isToken: true) {
            [weak self] response in
            guard let self else {
                return
            }
            switch response {
            case let .success(value):
                if value.value(forKey: Key.status) as? String ?? "" == "1" {
                    if let payloadObj = value.value(forKey: Key.payload) as? NSDictionary {
                        self.pObj = ProductModel(dict: payloadObj)
                        // self.pObj.detail =
                        self.nutritionArr = (payloadObj.value(forKey: "nutrition_list") as? NSArray ?? []).map { obj in

                            NutritionModel(dict: obj as? NSDictionary ?? [:])
                        }

                        self.imageArr = (payloadObj.value(forKey: "images") as? NSArray ?? []).map { obj in

                            ImageModel(dict: obj as? NSDictionary ?? [:])
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

    func serviceCallAddRemoveFav() {
        ServiceCall.post(parameter: ["prod_id": pObj.prodId], path: Globs.SV_ADD_REMOVE_FAVORITE, isToken: true) {
            [weak self] response in
            guard let self else {
                return
            }
            switch response {
            case let .success(value):
                if value.value(forKey: Key.status) as? String ?? "" == "1" {
                    self.isFav.toggle()
                    HomeViewModel.shared.serviceCallList()

                    self.alertMessage = value.value(forKey: Key.message) as? String ?? "Done"
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
