//
//  ImageModel.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 22/02/2025.
//

import Foundation
import SwiftUI

struct ImageModel: Identifiable, Equatable,Hashable {
    
    var id: Int = 0
    var image: String = ""
    var prodId: Int = 0
    
    
    init(dict: NSDictionary) {
        self.id = dict.value(forKey: "img_id") as? Int ?? 0
        self.image = dict.value(forKey: "image") as? String ?? ""
        self.prodId = dict.value(forKey: "prod_id") as? Int ?? 0
       
    }
    
    static func == (lhs: ImageModel, rhs: ImageModel) -> Bool {
        return lhs.id == rhs.id
    }
}
