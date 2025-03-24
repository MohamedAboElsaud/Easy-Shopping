//
//  ExploreCategoryModel.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 10/03/2025.
//

import Foundation
import SwiftUI

struct ExploreCategoryModel: Identifiable, Equatable, Hashable {
    var id: Int = 0
    var name: String = ""
    var image: String = ""
    var color: Color = .primaryApp

    init(dict: NSDictionary) {
        id = dict.value(forKey: "cat_id") as? Int ?? 0
        name = dict.value(forKey: "cat_name") as? String ?? ""
        image = dict.value(forKey: "image") as? String ?? ""
        color = Color(hex: dict.value(forKey: "color") as? String ?? "000000")
    }

    static func == (lhs: ExploreCategoryModel, rhs: ExploreCategoryModel) -> Bool {
        return lhs.id == rhs.id
    }
}
