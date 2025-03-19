//
//  FavoriteViewModel.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 09/03/2025.
//

import SwiftUI

class FavoriteViewModel: ObservableObject 
{
    static var shared: FavoriteViewModel = FavoriteViewModel()
    
    
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    @Published var listArr: [ProductModel] = []
    
    
    init() {
        serviceCallList()
    }
    
    
    
    //MARK: ServiceCall
    
    func serviceCallList(){
        ServiceCall.post(parameter: [:], path: Globs.SV_FAVORITE_LIST, isToken: true ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    self.listArr = (response.value(forKey: KKey.payload) as? NSArray ?? []).map({ obj in
                        return ProductModel(dict: obj as? NSDictionary ?? [:])
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
