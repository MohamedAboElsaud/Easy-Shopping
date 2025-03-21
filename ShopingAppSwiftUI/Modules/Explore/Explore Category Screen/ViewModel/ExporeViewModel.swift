//
//  ExporeViewModel.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 10/03/2025.
//

import SwiftUI

final class ExploreViewModel: ObservableObject {
    @Published var textFieldSearch: String = ""
    
    
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    @Published var listArr: [ExploreCategoryModel] = []

    init() {

    }

    func setup() {
        serviceCallList()
    }

    //MARK: ServiceCall
    
    func serviceCallList() {
        ServiceCall.post(parameter: [:], path: Globs.SV_EXPLORE_LIST, isToken: true) { [weak self] response in
            guard let self else { return }
            switch response {
            case .success(let value):
                if value.value(forKey: Key.status) as? String ?? "" == "1" {
                    self.listArr = (value.value(forKey: Key.payload) as? NSArray ?? []).map({ obj in
                        return ExploreCategoryModel(dict: obj as? NSDictionary ?? [:])
                    })
                }
            case .failure(let error):
                alertMessage = error.localizedDescription
                showAlert = true
            }
        }
    }
    
}
