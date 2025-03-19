//
//  PromoCodeViewModel.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 13/03/2025.
//

import SwiftUI

class PromoCodeViewModel: ObservableObject
{
    static var shared: PromoCodeViewModel = PromoCodeViewModel()
    
    
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    @Published var listArr: [PromoCodeModel] = []
    
    
    init() {
        serviceCallList()
    }
    
    //MARK: ServiceCall
    
    func serviceCallList(){
        ServiceCall.post(parameter: [:], path: Globs.SV_PROMO_CODE_LIST, isToken: true ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    
                    self.listArr = (response.value(forKey: KKey.payload) as? NSArray ?? []).map({ obj in
                        return PromoCodeModel(dict: obj as? NSDictionary ?? [:])
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
