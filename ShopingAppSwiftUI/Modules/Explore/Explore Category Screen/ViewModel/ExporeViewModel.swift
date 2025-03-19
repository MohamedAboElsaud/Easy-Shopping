//
//  ExporeViewModel.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 10/03/2025.
//

import SwiftUI

class ExporeViewModel: ObservableObject
{
    static var shared: ExporeViewModel = ExporeViewModel()
    
    @Published var textFieldSearch: String = ""
    
    
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    @Published var listArr: [ExploreCategoryModel] = []
    
    
    init() {
        serviceCallList()
    }
    
    
    
    //MARK: ServiceCall
    
    func serviceCallList(){
        ServiceCall.post(parameter: [:], path: Globs.SV_EXPLORE_LIST, isToken: true ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    self.listArr = (response.value(forKey: KKey.payload) as? NSArray ?? []).map({ obj in
                        
                        return ExploreCategoryModel(dict: obj as? NSDictionary ?? [:])
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
