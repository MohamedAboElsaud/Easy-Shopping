//
//  MyDetailsView.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 16/03/2025.
//

import CountryPicker
import SwiftUI

struct MyDetailsView: View {
    @Environment(\.presentationMode) var presentMode: Binding<PresentationMode>
    @StateObject var accountDetailsViewModel = AccountDetailsViewModel.shared

    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 15) {
                    LineTextField(textField: $accountDetailsViewModel.textFieldName, title: "Name", placeholder: "Enter you name")

                    VStack {
                        Text("Mobile")
                            .font(.customFont(.semibold, fontSize: 16))
                            .foregroundColor(.textTitle)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)

                        HStack {
                            Button {
                                accountDetailsViewModel.isShowPicker = true

                            } label: {
                                if let countryPickerObject = accountDetailsViewModel.countryPickerObject {
                                    Text("\(countryPickerObject.isoCode.getFlag())")
                                        .font(.customFont(.medium, fontSize: 35))

                                    Text("+\(countryPickerObject.phoneCode)")
                                        .font(.customFont(.medium, fontSize: 18))
                                        .foregroundColor(.primaryText)
                                }
                            }

                            TextField("Enter you mobile number", text: $accountDetailsViewModel.textFieldMobile)
                                .keyboardType(.numberPad)
                                .frame(minWidth: 0, maxWidth: .infinity)
                        }

                        Divider()
                    }

                    LineTextField(textField: $accountDetailsViewModel.textFieldUsername, title: "Username", placeholder: "Enter you username")

                    RoundButton(title: "Update") {
                        accountDetailsViewModel.serviceCallUpdate()
                    }
                    .padding(.bottom, 45)

                    NavigationLink {
                        ChangePasswordView()
                    } label: {
                        Text("Change Password")
                            .font(.customFont(.bold, fontSize: 18))
                            .foregroundColor(.primaryApp)
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

                    Text("My Details")
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

        .sheet(isPresented: $accountDetailsViewModel.isShowPicker, content: {
            CountryPickerUI(country: $accountDetailsViewModel.countryPickerObject)
        })
        .alert(isPresented: $accountDetailsViewModel.showAlert) {
            Alert(title: Text(Globs.AppName), message: Text(accountDetailsViewModel.alertMessage), dismissButton: .default(Text("Ok")))
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

struct MyDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MyDetailsView()
        }
    }
}
