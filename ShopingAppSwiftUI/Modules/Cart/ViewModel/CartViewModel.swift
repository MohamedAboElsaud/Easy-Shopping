//
//  CartViewModel.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 11/03/2025.
//

import SwiftUI

class CartViewModel: ObservableObject {
    static var shared: CartViewModel = .init()

    @Published var showAlert = false
    @Published var showOrderAccept = false
    @Published var alertMessage = ""

    @Published var listArr: [CartItemModel] = []
    @Published var total: String = "0.0"

    @Published var showCheckout: Bool = false

    @Published var showPickerAddress: Bool = false
    @Published var showPickerPayment: Bool = false
    @Published var showPickerPromoCode: Bool = false

    @Published var deliveryType: Int = 1
    @Published var paymentType: Int = 1
    @Published var deliverObj: AddressModel?
    @Published var paymentObj: PaymentModel?
    @Published var promoObj: PromoCodeModel?

    @Published var deliverPriceAmount: String = ""
    @Published var discountAmount: String = ""
    @Published var userPayAmount: String = ""

    init() {
        serviceCallList()
    }

    // MARK: ServiceCall

    func serviceCallList() {
        ServiceCall.post(parameter: ["promo_code_id": promoObj?.id ?? "", "delivery_type": deliveryType], path: Globs.SV_CART_LIST, isToken: true) {
            [weak self] response in
            guard let self else {
                return
            }
            switch response {
            case let .success(value):
                if value.value(forKey: Key.status) as? String ?? "" == "1" {
                    self.total = value.value(forKey: "total") as? String ?? "0.0"
                    self.discountAmount = value.value(forKey: "discount_amount") as? String ?? "0.0"
                    self.deliverPriceAmount = value.value(forKey: "deliver_price_amount") as? String ?? "0.0"
                    self.userPayAmount = value.value(forKey: "user_pay_price") as? String ?? "0.0"

                    self.listArr = (value.value(forKey: Key.payload) as? NSArray ?? []).map { obj in
                        CartItemModel(dict: obj as? NSDictionary ?? [:])
                    }

                } else {
                    self.total = value.value(forKey: "total") as? String ?? "0.0"
                    self.discountAmount = value.value(forKey: "discount_amount") as? String ?? "0.0"
                    self.deliverPriceAmount = value.value(forKey: "deliver_price_amount") as? String ?? "0.0"
                    self.userPayAmount = value.value(forKey: "user_pay_price") as? String ?? "0.0"

                    self.alertMessage = value.value(forKey: Key.message) as? String ?? "Fail"
                    self.showAlert = true
                }

            case let .failure(error):
                alertMessage = error.localizedDescription
                showAlert = true
            }
        }
    }

    func serviceCallUpdateQty(cObj: CartItemModel, newQty: Int) {
        ServiceCall.post(parameter: ["cart_id": cObj.cartId, "prod_id": cObj.prodId, "new_qty": newQty], path: Globs.SV_UPDATE_CART, isToken: true) {
            [weak self] response in
            guard let self else {
                return
            }
            switch response {
            case let .success(value):
                if value.value(forKey: Key.status) as? String ?? "" == "1" {
                    self.serviceCallList()

                } else {
                    self.alertMessage = value.value(forKey: Key.message) as? String ?? "Fail"
                    self.showAlert = true
                }
            case let .failure(error):
                alertMessage = error.localizedDescription
                showAlert = true
            }
        }
    }

    func serviceCallRemove(cObj: CartItemModel) {
        ServiceCall.post(parameter: ["cart_id": cObj.cartId, "prod_id": cObj.prodId], path: Globs.SV_REMOVE_CART, isToken: true) {
            [weak self] response in
            guard let self else {
                return
            }
            switch response {
            case let .success(value):
                if value.value(forKey: Key.status) as? String ?? "" == "1" {
                    self.serviceCallList()

                } else {
                    self.alertMessage = value.value(forKey: Key.message) as? String ?? "Fail"
                    self.showAlert = true
                }
            case let .failure(error):
                alertMessage = error.localizedDescription
                showAlert = true
            }
        }
    }

    func serviceCallOrderPlace() {
        if deliveryType == 1 && deliverObj == nil {
            alertMessage = "Please select delivery address"
            showAlert = true
            return
        }

        if paymentType == 2 && paymentObj == nil {
            alertMessage = "Please select payment method"
            showAlert = true
            return
        }

        ServiceCall.post(parameter: ["address_id": deliveryType == 2 ? "" : "\(deliverObj?.id ?? 0)",
                                     "deliver_type": deliveryType,
                                     "payment_type": paymentType,
                                     "pay_id": paymentType == 1 ? "" : "\(paymentObj?.id ?? 0)",
                                     "promo_code_id": promoObj?.id ?? ""], path: Globs.SV_ORDER_PLACE, isToken: true)
        {
            [weak self] response in
            guard let self else {
                return
            }
            switch response {
            case let .success(value):
                if value.value(forKey: Key.status) as? String ?? "" == "1" {
                    self.deliverObj = nil
                    self.paymentObj = nil
                    self.promoObj = nil
                    self.showCheckout = false
                    self.alertMessage = value.value(forKey: Key.message) as? String ?? "Success"
                    self.showAlert = true
                    self.serviceCallList()

                    self.showOrderAccept = true

                } else {
                    self.alertMessage = value.value(forKey: Key.message) as? String ?? "Fail"
                    self.showAlert = true
                }
            case let .failure(error):
                alertMessage = error.localizedDescription
                showAlert = true
            }
        }
    }

    func serviceCallAddToCart(prodId: Int, qty: Int, didDone: ((_ isDone: Bool, _ message: String) -> Void)?) {
        ServiceCall.post(parameter: ["prod_id": prodId, "qty": qty], path: Globs.SV_ADD_CART, isToken: true) {
            [weak self] response in
            guard let self else {
                return
            }
            switch response {
            case let .success(value):
                if value.value(forKey: Key.status) as? String ?? "" == "1" {
                    didDone?(true, value.value(forKey: Key.message) as? String ?? "Done")
                } else {
                    didDone?(false, value.value(forKey: Key.message) as? String ?? "Fail")
                }
            case let .failure(error):
                CartViewModel.shared.alertMessage = error.localizedDescription
                CartViewModel.shared.showAlert = true
            }
        }
    }
}
