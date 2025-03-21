//
//  ProductDetailViewModel.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 22/02/2025.
//

import SwiftUI

class ProductDetailViewModel: ObservableObject
{
    @Published var pObj: ProductModel = ProductModel(dict: [:])
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    @Published var nutritionArr: [NutritionModel] = []
    @Published var imageArr: [ImageModel] = []
    
    
    @Published var isFav: Bool = false
    @Published var isShowDetail: Bool = false
    @Published var isShowNutrition: Bool = false
    @Published var qty: Int = 1
    
    func showDetail(){
        isShowDetail = !isShowDetail
    }
    
    func showNutrition(){
        isShowNutrition = !isShowNutrition
    }
    
    func addSubQTY(isAdd: Bool = true) {
        if(isAdd) {
            qty += 1
            if(qty > 99) {
                qty = 99
            }
        }else{
            qty -= 1
            if(qty < 1) {
                qty = 1
            }
        }
    }
    
    
    init(prodObj: ProductModel) {
        self.pObj = prodObj
        self.isFav = prodObj.isFav
        serviceCallDetail()
    }
    
    //MARK: ServiceCall
    
    func serviceCallDetail(){
        ServiceCall.post(parameter: ["prod_id": self.pObj.prodId ], path: Globs.SV_PRODUCT_DETAIL, isToken: true ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: Key.status) as? String ?? "" == "1" {
                    
                    if let payloadObj = response.value(forKey: Key.payload) as? NSDictionary {
                        
                        
                        self.pObj = ProductModel(dict: payloadObj)
                       // self.pObj.detail =
                        self.nutritionArr = (payloadObj.value(forKey: "nutrition_list") as? NSArray ?? []).map({ obj in
                            
                            return NutritionModel(dict: obj as? NSDictionary ?? [:])
                        })
                        
                        self.imageArr = (payloadObj.value(forKey: "images") as? NSArray ?? []).map({ obj in
                            
                            return ImageModel(dict: obj as? NSDictionary ?? [:])
                        })
                    }
                    
                    
                }else{
                    self.alertMessage = response.value(forKey: Key.message) as? String ?? "Fail"
                    self.showAlert = true
                }
            }
        } failure: { error in
            self.alertMessage = error?.localizedDescription ?? "Fail"
            self.showAlert = true
        }
    }
    
    func serviceCallAddRemoveFav(){
        ServiceCall.post(parameter: ["prod_id": self.pObj.prodId ], path: Globs.SV_ADD_REMOVE_FAVORITE, isToken: true ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: Key.status) as? String ?? "" == "1" {
                    
                    self.isFav = !self.isFav
                    HomeViewModel.shared.serviceCallList()
                    
                    self.alertMessage = response.value(forKey: Key.message) as? String ?? "Done"
                    self.showAlert = true
                }else{
                    self.alertMessage = response.value(forKey: Key.message) as? String ?? "Fail"
                    self.showAlert = true
                }
            }
        } failure: { error in
            self.alertMessage = error?.localizedDescription ?? "Fail"
            self.showAlert = true
        }
    }
    
    
}
