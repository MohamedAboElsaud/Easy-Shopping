//
//  CheckoutView.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 14/03/2025.
//

import SwiftUI

struct CheckoutView: View {
    @Binding var isShow: Bool
    @StateObject var cartVM = CartViewModel.shared

    var body: some View {
        VStack {
            Spacer()
            VStack {
                HStack {
                    Text("Checkout")
                        .font(.customFont(.bold, fontSize: 20))
                        .frame(height: 46)
                    Spacer()

                    Button {
                        withAnimation(.easeInOut(duration: 0.6)) {
                            $isShow.wrappedValue = false
                        }
                    } label: {
                        Image("close")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }
                }
                .padding(.top, 30)

                Divider()

                VStack {
                    HStack {
                        Text("Delivery Type")
                            .font(.customFont(.semibold, fontSize: 18))
                            .foregroundColor(.secondaryText)
                            .frame(height: 46)

                        Spacer()

                        Picker("", selection: $cartVM.deliveryType) {
                            Text("Delivery").tag(1)
                            Text("Collection").tag(2)
                        }
                        .pickerStyle(.segmented)
                        .frame(width: 180)
                    }

                    Divider()

                    if cartVM.deliveryType == 1 {
                        NavigationLink {
                            DelieryAddressView(isPicker: true, didSelect: {
                                aObj in
                                cartVM.deliverObj = aObj
                            })
                        } label: {
                            HStack {
                                Text("Delivery")
                                    .font(.customFont(.semibold, fontSize: 18))
                                    .foregroundColor(.secondaryText)
                                    .frame(height: 46)

                                Spacer()

                                Text(cartVM.deliverObj?.name ?? "Select Method")
                                    .font(.customFont(.semibold, fontSize: 18))
                                    .foregroundColor(.primaryText)
                                    .frame(height: 46)

                                Image("next")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.primaryText)
                            }
                        }

                        Divider()
                    }

                    HStack {
                        Text("Payment Type")
                            .font(.customFont(.semibold, fontSize: 18))
                            .foregroundColor(.secondaryText)
                            .frame(height: 46)

                        Spacer()

                        Picker("", selection: $cartVM.paymentType) {
                            Text("COD").tag(1)
                            Text("Online").tag(2)
                        }
                        .pickerStyle(.segmented)
                        .frame(width: 150)
                    }

                    Divider()
                    if cartVM.paymentType == 2 {
                        NavigationLink {
                            PaymentMethodsView(isPicker: true, didSelect: {
                                pObj in
                                cartVM.paymentObj = pObj
                            })
                        } label: {
                            HStack {
                                Text("Payment")
                                    .font(.customFont(.semibold, fontSize: 18))
                                    .foregroundColor(.secondaryText)
                                    .frame(height: 46)

                                Spacer()

                                Image("master")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 20)

                                Text(cartVM.paymentObj?.cardNumber ?? "Select")
                                    .font(.customFont(.semibold, fontSize: 18))
                                    .foregroundColor(.primaryText)
                                    .frame(height: 46)

                                Image("next")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.primaryText)
                            }
                        }

                        Divider()
                    }

                    NavigationLink {
                        PromoCodeView(isPicker: true, didSelect: {
                            pObj in
                            cartVM.promoObj = pObj
                        })
                    } label: {
                        HStack {
                            Text("Promo Code")
                                .font(.customFont(.semibold, fontSize: 18))
                                .foregroundColor(.secondaryText)
                                .frame(height: 46)

                            Spacer()

                            Text(cartVM.promoObj?.code ?? "Pick Discount")
                                .font(.customFont(.semibold, fontSize: 18))
                                .foregroundColor(.primaryText)
                                .frame(height: 46)

                            Image("next")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.primaryText)
                        }
                    }

                    Divider()
                }

                VStack {
                    HStack {
                        Text("Totat")
                            .font(.customFont(.semibold, fontSize: 16))
                            .foregroundColor(.secondaryText)

                        Spacer()

                        Text("$ \(cartVM.total)")
                            .font(.customFont(.semibold, fontSize: 16))
                            .foregroundColor(.secondaryText)
                    }

                    HStack {
                        Text("Delivery Cost")
                            .font(.customFont(.semibold, fontSize: 16))
                            .foregroundColor(.secondaryText)

                        Spacer()

                        Text("+ $ \(cartVM.deliverPriceAmount)")
                            .font(.customFont(.semibold, fontSize: 16))
                            .foregroundColor(.secondaryText)
                    }

                    HStack {
                        Text("Discount")
                            .font(.customFont(.semibold, fontSize: 16))
                            .foregroundColor(.secondaryText)

                        Spacer()

                        Text("- $ \(cartVM.discountAmount)")
                            .font(.customFont(.semibold, fontSize: 16))
                            .foregroundColor(.red)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 15)

                HStack {
                    Text("Final Total")
                        .font(.customFont(.semibold, fontSize: 18))
                        .foregroundColor(.secondaryText)
                        .frame(height: 46)

                    Spacer()

                    Text("$\(cartVM.userPayAmount)")
                        .font(.customFont(.semibold, fontSize: 18))
                        .foregroundColor(.primaryText)
                        .frame(height: 46)

                    Image("next")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.primaryText)
                }
                Divider()

                VStack {
                    Text("By continuing you agree to our")
                        .font(.customFont(.semibold, fontSize: 14))
                        .foregroundColor(.secondaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)

                    HStack {
                        Text("Terms of Service")
                            .font(.customFont(.semibold, fontSize: 14))
                            .foregroundColor(.primaryText)

                        Text(" and ")
                            .font(.customFont(.semibold, fontSize: 14))
                            .foregroundColor(.secondaryText)

                        Text("Privacy Policy.")
                            .font(.customFont(.semibold, fontSize: 14))
                            .foregroundColor(.primaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding(.vertical, .screenWidth * 0.03)

                RoundButton(title: "Place Order") {
                    cartVM.serviceCallOrderPlace()
                }
                .padding(.bottom, .bottomInsets + 70)
            }
            .padding(.horizontal, 20)
            .background(Color.white)
            .cornerRadius(20, corner: [.topLeft, .topRight])
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    @State static var isShow: Bool = false
    static var previews: some View {
        NavigationView {
            CheckoutView(isShow: $isShow)
        }
    }
}
