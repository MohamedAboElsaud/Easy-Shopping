//
//  PaymentModel.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 14/03/2025.
//

import SwiftUI

struct PaymentModel: Identifiable, Equatable {
    var id: Int = 0
    var name: String = ""
    var cardNumber: String = ""
    var cardMonth: String = ""
    var cardYear: String = ""

    init(dict: NSDictionary) {
        id = dict.value(forKey: "pay_id") as? Int ?? 0
        name = dict.value(forKey: "name") as? String ?? ""
        cardNumber = dict.value(forKey: "card_number") as? String ?? ""
        cardMonth = dict.value(forKey: "card_month") as? String ?? ""
        cardYear = dict.value(forKey: "card_year") as? String ?? ""
    }

    static func == (lhs: PaymentModel, rhs: PaymentModel) -> Bool {
        return lhs.id == rhs.id
    }
}
