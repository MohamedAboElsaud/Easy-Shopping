//
//  ProductModel.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 19/02/2025.
//

import Foundation

struct ProductModel: Identifiable, Equatable, Hashable {
    var id: Int = 0
    var prodId: Int = 0
    var catId: Int = 0
    var brandId: Int = 0
    var typeId: Int = 0
    var orderId: Int = 0
    var qty: Int = 0
    var detail: String = ""
    var name: String = ""
    var unitName: String = ""
    var unitValue: String = ""
    var nutritionWeight: String = ""
    var image: String = ""
    var catName: String = ""
    var typeName: String = ""
    var offerPrice: Double?
    var itemPrice: Double = 0.0
    var totalPrice: Double = 0.0
    var price: Double = 0
    var startDate: Date = .init()
    var endDate: Date = .init()
    var isFav: Bool = false
    var avgRating: Int = 0

    init(dict: NSDictionary) {
        id = dict.value(forKey: "prod_id") as? Int ?? 0
        prodId = dict.value(forKey: "prod_id") as? Int ?? 0
        catId = dict.value(forKey: "cat_id") as? Int ?? 0
        brandId = dict.value(forKey: "brand_id") as? Int ?? 0
        typeId = dict.value(forKey: "type_id") as? Int ?? 0
        orderId = dict.value(forKey: "order_id") as? Int ?? 0
        qty = dict.value(forKey: "qty") as? Int ?? 0
        isFav = dict.value(forKey: "is_fav") as? Int ?? 0 == 1

        detail = dict.value(forKey: "detail") as? String ?? ""
        name = dict.value(forKey: "name") as? String ?? ""
        unitName = dict.value(forKey: "unit_name") as? String ?? ""
        unitValue = dict.value(forKey: "unit_value") as? String ?? ""
        nutritionWeight = dict.value(forKey: "nutrition_weight") as? String ?? ""
        image = dict.value(forKey: "image") as? String ?? ""
        catName = dict.value(forKey: "cat_name") as? String ?? ""
        typeName = dict.value(forKey: "type_name") as? String ?? ""
        offerPrice = dict.value(forKey: "offer_price") as? Double
        price = dict.value(forKey: "price") as? Double ?? 0
        itemPrice = dict.value(forKey: "item_price") as? Double ?? 0
        totalPrice = dict.value(forKey: "total_price") as? Double ?? 0
        startDate = (dict.value(forKey: "start_date") as? String ?? "").stringDatetoDate() ?? Date()
        endDate = (dict.value(forKey: "end_date") as? String ?? "").stringDatetoDate() ?? Date()
        avgRating = Int("\(dict.value(forKey: "rating") ?? "")") ?? 0
    }

    static func == (lhs: ProductModel, rhs: ProductModel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
