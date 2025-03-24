//
//  MyOrderModel.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 15/03/2025.
//

import SwiftUI

struct MyOrderModel: Identifiable, Equatable {
    var id: Int = 0
    var cartId: Int = 0
    var totalPrice: Double = 0
    var userPayPrice: Double?
    var discountPrice: Double?
    var deliverPrice: Double?
    var deliverType: Int = 0
    var paymentType: Int = 0
    var paymentStatus: Int = 0
    var orderStatus: Int = 0
    var status: Int = 0
    var names: String = ""
    var userName: String = ""
    var phone: String = ""
    var address: String = ""
    var city: String = ""
    var state: String = ""
    var postalCode: String = ""
    var images: [String] = []

    var createdDate: Date = .init()

    init(dict: NSDictionary) {
        id = dict.value(forKey: "order_id") as? Int ?? 0

        cartId = dict.value(forKey: "cart_id") as? Int ?? 0

        totalPrice = dict.value(forKey: "total_price") as? Double ?? 0.0
        userPayPrice = dict.value(forKey: "user_pay_price") as? Double ?? 0.0
        discountPrice = dict.value(forKey: "discount_price") as? Double ?? 0.0
        deliverPrice = dict.value(forKey: "deliver_price") as? Double ?? 0.0

        deliverType = dict.value(forKey: "deliver_type") as? Int ?? 0
        paymentType = dict.value(forKey: "payment_type") as? Int ?? 0
        paymentStatus = dict.value(forKey: "payment_status") as? Int ?? 0
        orderStatus = dict.value(forKey: "order_status") as? Int ?? 0
        status = dict.value(forKey: "status") as? Int ?? 0

        names = dict.value(forKey: "names") as? String ?? ""
        userName = dict.value(forKey: "user_name") as? String ?? ""
        phone = dict.value(forKey: "phone") as? String ?? ""
        address = dict.value(forKey: "address") as? String ?? ""
        city = dict.value(forKey: "city") as? String ?? ""
        state = dict.value(forKey: "state") as? String ?? ""
        postalCode = dict.value(forKey: "postal_code") as? String ?? ""

        images = (dict.value(forKey: "images") as? String ?? "").components(separatedBy: ",")
        createdDate = (dict.value(forKey: "created_date") as? String ?? "").stringDatetoDate() ?? Date()
    }

    static func == (lhs: MyOrderModel, rhs: MyOrderModel) -> Bool {
        return lhs.id == rhs.id
    }
}
