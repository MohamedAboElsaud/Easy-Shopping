//
//  HomeViewModel.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 19/02/2025.
//

import SwiftUI

class HomeViewModel: ObservableObject {
        static var shared: HomeViewModel = HomeViewModel()
        
//        @Published var selectTab: Int = 0
        @Published var textFieldSearch: String = ""
        
        
        @Published var showAlert = false
        @Published var alertMessage = ""
        
        @Published var offerArr: [ProductModel] = []
        @Published var bestArr: [ProductModel] = []
        @Published var listArr: [ProductModel] = []
        @Published var typeArr: [TypeModel] = []
        
        
        init() {
            serviceCallList()
        }
        
        
        
        //MARK: ServiceCall
        
        func serviceCallList(){
            ServiceCall.post(parameter: [:], path: Globs.SV_HOME, isToken: true ) { responseObj in
                if let response = responseObj as? NSDictionary {
                    if response.value(forKey: Key.status) as? String ?? "" == "1" {
                        
                        if let payloadObj = response.value(forKey: Key.payload) as? NSDictionary {
                            self.offerArr = (payloadObj.value(forKey: "offer_list") as? NSArray ?? []).map({ obj in
                                
                                return ProductModel(dict: obj as? NSDictionary ?? [:])
                            })
                            
                            self.bestArr = (payloadObj.value(forKey: "best_sell_list") as? NSArray ?? []).map({ obj in
                                
                                return ProductModel(dict: obj as? NSDictionary ?? [:])
                            })
                            
                            self.listArr = (payloadObj.value(forKey: "list") as? NSArray ?? []).map({ obj in
                                
                                return ProductModel(dict: obj as? NSDictionary ?? [:])
                            })
                            
                            self.typeArr = (payloadObj.value(forKey: "type_list") as? NSArray ?? []).map({ obj in
                                
                                return TypeModel(dict: obj as? NSDictionary ?? [:])
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
        
    }
