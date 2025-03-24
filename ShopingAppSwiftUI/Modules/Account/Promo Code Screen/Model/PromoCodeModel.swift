//
//  PromoCodeModel.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 13/03/2025.
//

import SwiftUI

struct PromoCodeModel: Identifiable, Equatable, Hashable {
    var id: Int = 0
    var type: Int = 0

    var title: String = ""
    var code: String = ""
    var description: String = ""
    var startDate: Date = .init()
    var endDate: Date = .init()
    var minOrderAmount: Double = 0.0
    var maxDiscountAmount: Double = 0.0
    var offerPrice: Double = 0.0

    init(dict: NSDictionary) {
        id = dict.value(forKey: "promo_code_id") as? Int ?? 0
        title = dict.value(forKey: "title") as? String ?? ""
        code = dict.value(forKey: "code") as? String ?? ""
        description = dict.value(forKey: "description") as? String ?? ""
        startDate = (dict.value(forKey: "start_date") as? String ?? "").stringDatetoDate() ?? Date()
        endDate = (dict.value(forKey: "end_date") as? String ?? "").stringDatetoDate() ?? Date()
        type = dict.value(forKey: "type") as? Int ?? 0
        minOrderAmount = dict.value(forKey: "min_order_amount") as? Double ?? 0
        maxDiscountAmount = dict.value(forKey: "max_discount_amount") as? Double ?? 0
        offerPrice = dict.value(forKey: "offer_price") as? Double ?? 0
    }

    static func == (lhs: PromoCodeModel, rhs: PromoCodeModel) -> Bool {
        return lhs.id == rhs.id
    }
}
