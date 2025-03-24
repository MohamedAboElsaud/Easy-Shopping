//
//  TypeModel.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 19/02/2025.
//

import Foundation
import SwiftUI

struct TypeModel: Identifiable, Equatable, Hashable {
    var id: Int = 0
    var name: String = ""
    var image: String = ""
    var color: Color = .primaryApp

    init(dict: NSDictionary) {
        id = dict.value(forKey: "type_id") as? Int ?? 0
        name = dict.value(forKey: "type_name") as? String ?? ""
        image = dict.value(forKey: "image") as? String ?? ""
        color = Color(hex: dict.value(forKey: "color") as? String ?? "000000")
    }

    static func == (lhs: TypeModel, rhs: TypeModel) -> Bool {
        return lhs.id == rhs.id
    }
}
