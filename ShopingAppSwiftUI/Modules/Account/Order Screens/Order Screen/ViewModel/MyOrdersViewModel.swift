//
//  MyOrdersViewModel.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 15/03/2025.
//

import SwiftUI

class MyOrdersViewModel: ObservableObject
{
    static var shared: MyOrdersViewModel = MyOrdersViewModel()
    
    
    
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    @Published var listArr: [MyOrderModel] = []
    
    
    init() {
        serviceCallList()
    }
    
    
    //MARK: ServiceCall
    
    func serviceCallList(){
        ServiceCall.post(parameter: [:], path: Globs.SV_MY_ORDERS_LIST, isToken: true ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    
                    self.listArr = (response.value(forKey: KKey.payload) as? NSArray ?? []).map({ obj in
                        return MyOrderModel(dict: obj as? NSDictionary ?? [:])
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
    
    
    
    
}
