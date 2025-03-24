//
//  PaymentMethodsView.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 14/03/2025.
//

import SwiftUI

struct PaymentMethodsView: View {
    @Environment(\.presentationMode) var presentMode: Binding<PresentationMode>

    @StateObject var paymentViewModel = PaymentViewModel.shared
    @State var isPicker: Bool = false
    var didSelect: ((_ obj: PaymentModel) -> Void)?

    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack(spacing: 15) {
                    ForEach(paymentViewModel.listArr, id: \.id, content: {
                        pObj in

                        HStack(spacing: 15) {
                            Image("paymenth_methods")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 35, height: 35)

                            VStack(spacing: 4) {
                                Text(pObj.name)
                                    .font(.customFont(.bold, fontSize: 18))
                                    .foregroundColor(.primaryText)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)

                                Text("**** **** **** \(pObj.cardNumber) ")
                                    .font(.customFont(.medium, fontSize: 15))
                                    .foregroundColor(.primaryApp)
                                    .multilineTextAlignment(.leading)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            }

                            Button {
                                paymentViewModel.serviceCallRemove(pObj: pObj)
                            } label: {
                                Image("close")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                            }
                        }
                        .padding(15)
                        .background(Color.white)
                        .cornerRadius(5)
                        .shadow(color: Color.black.opacity(0.15), radius: 2)
                        .onTapGesture {
                            if isPicker {
                                presentMode.wrappedValue.dismiss()
                                didSelect?(pObj)
                            }
                        }
                    })
                }
                .padding(20)
                .padding(.top, .topInsets + 46)
                .padding(.bottom, .bottomInsets + 60)
            }
            VStack {
                HStack {
                    Button {
                        presentMode.wrappedValue.dismiss()
                    } label: {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                    Spacer()

                    Text("Payment Methods")
                        .font(.customFont(.bold, fontSize: 20))
                        .frame(height: 46)
                    Spacer()

                    NavigationLink {
                        AddPaymentMethodView()
                    } label: {
                        Image("add_temp")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }

                    .foregroundColor(.primaryText)
                }
                .padding(.top, .topInsets)
                .padding(.horizontal, 20)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.2), radius: 2)

                Spacer()
            }
        }
        .alert(isPresented: $paymentViewModel.showAlert, content: {
            Alert(title: Text(Globs.AppName), message: Text(paymentViewModel.alertMessage))
        })
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

struct PaymentMethodsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PaymentMethodsView()
        }
    }
}
