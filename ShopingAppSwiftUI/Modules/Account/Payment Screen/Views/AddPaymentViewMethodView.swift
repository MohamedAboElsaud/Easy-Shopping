//
//  AddPaymentViewMethodView.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 14/03/2025.
//

import SwiftUI

struct AddPaymentMethodView: View {
    @Environment(\.presentationMode) var presentMode: Binding<PresentationMode>
    @StateObject var paymentViewModel = PaymentViewModel.shared

    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 15) {
                    LineTextField(textField: $paymentViewModel.textFieldName, title: "Name", placeholder: "Enter you name")

                    LineTextField(textField: $paymentViewModel.textFieldCardNumber, title: "Card Number", placeholder: "Enter card number", keyboardType: .numberPad)

                    HStack {
                        LineTextField(textField: $paymentViewModel.textFieldCardMonth, title: "MM", placeholder: "Enter Month", keyboardType: .numberPad)

                        LineTextField(textField: $paymentViewModel.textFieldCardYear, title: "YYYY", placeholder: "Enter Year", keyboardType: .numberPad)
                    }

                    RoundButton(title: "Add Payment Method") {
                        paymentViewModel.serviceCallAdd {
                            self.presentMode.wrappedValue.dismiss()
                        }
                    }
                }
                .padding(20)
                .padding(.top, .topInsets + 46)
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

                    Text("Add Payment Method")
                        .font(.customFont(.bold, fontSize: 20))
                        .frame(height: 46)
                    Spacer()
                }
                .padding(.top, .topInsets)
                .padding(.horizontal, 20)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.2), radius: 2)

                Spacer()
            }
        }

        .alert(isPresented: $paymentViewModel.showAlert) {
            Alert(title: Text(Globs.AppName), message: Text(paymentViewModel.alertMessage), dismissButton: .default(Text("Ok")))
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

struct AddPaymentMethodView_Previews: PreviewProvider {
    static var previews: some View {
        AddPaymentMethodView()
    }
}
