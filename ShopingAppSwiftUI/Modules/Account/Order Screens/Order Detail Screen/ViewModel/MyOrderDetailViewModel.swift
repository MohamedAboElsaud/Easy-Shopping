//
//  MyOrderDetailViewModel.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 15/03/2025.
//


import SwiftUI

class MyOrderDetailViewModel: ObservableObject {
    @Published var pObj: MyOrderModel = MyOrderModel(dict: [:])
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var listArr: [OrderItemModel] = []
    
    @Published var textFieldMessage = ""
    @Published var rating = 0
    @Published var showWriteReview = false
    @Published var productObj : OrderItemModel?
    
    
    init(prodObj: MyOrderModel) {
        self.pObj = prodObj
        serviceCallDetail()
    }
    
    
    func actionWriteReviewOpen(obj: OrderItemModel){
        
        rating = 5
        textFieldMessage = ""
        productObj = obj
        showWriteReview = true
    }
    //MARK: ServiceCall
    
    func serviceCallDetail(){
        ServiceCall.post(parameter: ["order_id": self.pObj.id ], path: Globs.SV_MY_ORDERS_DETAIL, isToken: true ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: Key.status) as? String ?? "" == "1" {
                    
                    if let payloadObj = response.value(forKey: Key.payload) as? NSDictionary {
                        
                        self.pObj = MyOrderModel(dict: payloadObj)
                        self.listArr = (payloadObj.value(forKey: "cart_list") as? NSArray ?? []).map({ obj in
                            
                            print(obj)
                            return OrderItemModel(dict: obj as? NSDictionary ?? [:])
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
    
    func serviceCallWriteReview(didDone: (()->())? ) {
        ServiceCall.post(parameter: ["order_id": self.pObj.id,"prod_id":self.productObj?.prodId ?? "" ,"rating":rating,"review_message": textFieldMessage ], path: Globs.SV_PRODUCT_RATING_REVIEW, isToken: true ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: Key.status) as? String ?? "" == "1" {
                    
                    self.showWriteReview = true
                    didDone?()
                    
                    self.serviceCallDetail()
                    //TODO: understand disqueue
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        self.alertMessage = response.value(forKey: Key.message) as? String ?? "Success"
                        self.showAlert = true
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
}
