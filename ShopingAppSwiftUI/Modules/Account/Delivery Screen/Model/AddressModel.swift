//
//  AddressModel.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 12/03/2025.
//

import SwiftUI

struct AddressModel: Identifiable, Equatable {
    var id: Int = 0
    var name: String = ""
    var phone: String = ""
    var address: String = ""
    var city: String = ""
    var state: String = ""
    var typeName: String = ""
    var postalCode: String = ""
    var isDefault: Int = 0

    init(dict: NSDictionary) {
        id = dict.value(forKey: "address_id") as? Int ?? 0
        name = dict.value(forKey: "name") as? String ?? ""
        phone = dict.value(forKey: "phone") as? String ?? ""
        address = dict.value(forKey: "address") as? String ?? ""
        city = dict.value(forKey: "city") as? String ?? ""
        state = dict.value(forKey: "state") as? String ?? ""
        typeName = dict.value(forKey: "type_name") as? String ?? ""
        postalCode = dict.value(forKey: "postal_code") as? String ?? ""
        isDefault = dict.value(forKey: "is_default") as? Int ?? 0
    }

    static func == (lhs: AddressModel, rhs: AddressModel) -> Bool {
        return lhs.id == rhs.id
    }
}
