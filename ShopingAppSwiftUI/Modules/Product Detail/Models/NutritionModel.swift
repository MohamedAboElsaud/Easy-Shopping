//
//  NutritionModel.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 22/02/2025.
//


import Foundation
import SwiftUI

struct NutritionModel: Identifiable, Equatable,Hashable {
    
    var id: Int = 0
    var nutritionName: String = ""
    var nutritionValue: String = ""
    
    
    
    init(dict: NSDictionary) {
        self.id = dict.value(forKey: "nutrition_id") as? Int ?? 0
        self.nutritionName = dict.value(forKey: "nutrition_name") as? String ?? ""
        self.nutritionValue = dict.value(forKey: "nutrition_value") as? String ?? ""
        
    }
    
    static func == (lhs: NutritionModel, rhs: NutritionModel) -> Bool {
        return lhs.id == rhs.id
    }
}
