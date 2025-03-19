//
//  PaymentViewModel.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 14/03/2025.
//
//


import SwiftUI

class PaymentViewModel: ObservableObject
{
    static var shared: PaymentViewModel = PaymentViewModel()
    
    
    @Published var textFieldName: String = ""
    @Published var textFieldCardNumber: String = ""
    @Published var textFieldCardMonth: String = ""
    @Published var textFieldCardYear: String = ""
    
    
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    @Published var listArr: [PaymentModel] = []
    
    
    init() {
        serviceCallList()
    }
    
    func clearAll(){
        textFieldName = ""
        textFieldCardNumber = ""
        textFieldCardYear = ""
        textFieldCardMonth = ""
        
    }
    
    
    //MARK: ServiceCall
    
    func serviceCallList(){
        ServiceCall.post(parameter: [:], path: Globs.SV_PAYMENT_METHOD_LIST, isToken: true ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    
                    self.listArr = (response.value(forKey: KKey.payload) as? NSArray ?? []).map({ obj in
                        return PaymentModel(dict: obj as? NSDictionary ?? [:])
                    })
                
                }else{
                    self.alertMessage = response.value(forKey: KKey.message) as? String ?? "Fail"
                    self.showAlert = true
                }
            }
        } failure: { error in
            self.alertMessage = error?.localizedDescription ?? "Fail"
            self.showAlert = true
        }
    }
    
    func serviceCallRemove(pObj: PaymentModel){
        ServiceCall.post(parameter: ["pay_id": pObj.id ], path: Globs.SV_REMOVE_PAYMENT_METHOD, isToken: true ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    self.serviceCallList()
                
                }else{
                    self.alertMessage = response.value(forKey: KKey.message) as? String ?? "Fail"
                    self.showAlert = true
                }
            }
        } failure: { error in
            self.alertMessage = error?.localizedDescription ?? "Fail"
            self.showAlert = true
        }
    }
    
    func serviceCallAdd(didDone: ((  )->())? ) {
            
        if(textFieldName.isEmpty) {
            alertMessage = "please enter name"
            showAlert = true
            return
        }
        
        if(textFieldCardNumber.count != 16) {
            alertMessage = "please enter valid card number"
            showAlert = true
            return
        }
        
        
        if(textFieldCardMonth.count != 2) {
            alertMessage = "please enter valid card month"
            showAlert = true
            return
        }
        
        if(textFieldCardYear.count != 4) {
            alertMessage = "please enter valid card year"
            showAlert = true
            return
        }
        
        ServiceCall.post(parameter: ["name":  textFieldName, "card_number": textFieldCardNumber, "card_month": textFieldCardMonth, "card_year": textFieldCardYear  ], path: Globs.SV_ADD_PAYMENT_METHOD, isToken: true ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    self.clearAll()
                    self.serviceCallList()
                    didDone?( )
                }else{
                    self.alertMessage = response.value(forKey: KKey.message) as? String ?? "Fail"
                    self.showAlert = true
                }
            }
        } failure: { error in
            self.alertMessage = error?.localizedDescription ?? "Fail"
            self.showAlert = true
        }

    }
    
    
}
