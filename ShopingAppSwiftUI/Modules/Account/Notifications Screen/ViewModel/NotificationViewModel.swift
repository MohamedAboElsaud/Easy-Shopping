//
//  NotificationViewModel.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 16/03/2025.
//

import SwiftUI

class NotificationViewModel: ObservableObject
{
    static var shared: NotificationViewModel = NotificationViewModel()
    
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    @Published var listArr: [NotificationModel] = []
    
    
    init() {
        serviceCallList()
    }
    
    
    //MARK: ServiceCall
    
    func serviceCallList(){
        ServiceCall.post(parameter: [:], path: Globs.SV_NOTIFICATION_LIST, isToken: true ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    
                    self.listArr = (response.value(forKey: KKey.payload) as? NSArray ?? []).map({ obj in
                        return NotificationModel(dict: obj as? NSDictionary ?? [:])
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
    
    func serviceCallReadAll(){
        ServiceCall.post(parameter: [:], path: Globs.SV_NOTIFICATION_READ_ALL, isToken: true ) { responseObj in
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
    
    
    
    
}
