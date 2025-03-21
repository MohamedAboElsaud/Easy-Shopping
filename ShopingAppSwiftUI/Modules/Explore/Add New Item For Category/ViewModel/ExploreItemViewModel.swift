//
//  ExploreItemViewModel.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 10/03/2025.
//

import Foundation

class ExploreItemViewModel: ObservableObject {
    @Published var cObj: ExploreCategoryModel = ExploreCategoryModel(dict: [:])
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    @Published var listArr: [ProductModel] = []
    
    
    init(catObj: ExploreCategoryModel) {
        self.cObj = catObj
        serviceCallList()
    }
    
    //MARK: ServiceCall
    
    func serviceCallList() {
        ServiceCall.post(parameter: ["cat_id": self.cObj.id ], path: Globs.SV_EXPLORE_ITEMS_LIST, isToken: true ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: Key.status) as? String ?? "" == "1" {
                    
                    self.listArr = (response.value(forKey: Key.payload) as? NSArray ?? []).map({ obj in
                        
                        return ProductModel(dict: obj as? NSDictionary ?? [:])
                    })
                    
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
