//
//  AddDeliveryAddressView.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 13/03/2025.
//

import SwiftUI

struct AddDeliveryAddressView: View {
    @StateObject var addressVM = DeliveryAddressViewModel.shared
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var isEdit: Bool = false
    @State var editObj: AddressModel?

    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 15) {
                    HStack {
                        Button {
                            addressVM.textFieldName = "Home"
                        } label: {
                            Image(systemName: addressVM.textFieldName == "Home" ? "record.circle" : "circle")
                            Text("Home")
                                .font(.customFont(.medium, fontSize: 16))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .foregroundColor(.primaryText)
                        Button {
                            addressVM.textFieldName = "Office"
                        } label: {
                            Image(systemName: addressVM.textFieldName == "Office" ? "record.circle" : "circle")
                            Text("Office")
                                .font(.customFont(.medium, fontSize: 16))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .foregroundColor(.primaryText)
                    }
                    .padding(.bottom, 15)

                    LineTextField(textField: $addressVM.textFieldName, title: "Name", placeholder: "Enter your name")

                    LineTextField(textField: $addressVM.textFieldMobile, title: "Mobile", placeholder: "Enter your Mobile", keyboardType: .numberPad)

                    LineTextField(textField: $addressVM.textFieldAddress, title: "Address Line", placeholder: "Enter your Address")

                    HStack {
                        LineTextField(textField: $addressVM.textFieldCity, title: "City", placeholder: "Enter your city")

                        LineTextField(textField: $addressVM.textFieldState, title: "State", placeholder: "Enter your State")
                    }

                    LineTextField(textField: $addressVM.textFieldPostalCode, title: "Postal Code", placeholder: "Enter your postal code")

                    RoundButton(title: isEdit ? "Update Address" : "Add Address") {
                        if isEdit {
                            addressVM.serviceCallUpdateAddress(aObj: editObj) {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        } else {
                            addressVM.serviceCallAddAddress {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }
                }
                .padding(20)
                .padding(.top, .topInsets + 46)
            }

            VStack {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                    Spacer()

                    Text(isEdit ? "Edit Delivery Address" : "Add Delivery Address")
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
        .onAppear {
            if isEdit {
                if let editObj = editObj {
                    addressVM.setData(aObj: editObj)
                }
            }
        }
        .alert(isPresented: $addressVM.showAlert) {
            Alert(title: Text(Globs.AppName), message: Text(addressVM.alertMessage), dismissButton: .default(Text("Ok")))
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

struct AddDeliveryAddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddDeliveryAddressView()
    }
}
