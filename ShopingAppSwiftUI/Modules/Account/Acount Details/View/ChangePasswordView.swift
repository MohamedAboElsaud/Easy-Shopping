//
//  ChangePasswordView.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 16/03/2025.
//

import SwiftUI

struct ChangePasswordView: View {
    @Environment(\.presentationMode) var presentMode : Binding<PresentationMode>
    @StateObject var accountDetailsViewModel = AccountDetailsViewModel.shared
    
   
    
    var body: some View {
        ZStack {
            
            ScrollView{
                VStack(spacing: 15){
                    
                    LineSecureField(textField: $accountDetailsViewModel.textFieldCurrentPassword, isPassword: $accountDetailsViewModel.isCurrentPassword, title: "Current Password", placeholder: "Enter your current password")
                        .padding(.bottom, .screenWidth * 0.02)
                    
                    LineSecureField(textField: $accountDetailsViewModel.textFieldNewPassword, isPassword: $accountDetailsViewModel.isNewPassword,title: "New Password", placeholder: "Enter your new password")
                        .padding(.bottom, .screenWidth * 0.02)
                    
                    LineSecureField(textField: $accountDetailsViewModel.textFieldConfirmPassword, isPassword: $accountDetailsViewModel.isConfirmPassword,title: "Confirm Password", placeholder: "Enter your confirm password")
                        .padding(.bottom, .screenWidth * 0.02)
                    
                    RoundButton(title: "Update") {
                        accountDetailsViewModel.serviceCallChangePassword()
                    }
                    .padding(.bottom, 45)
                    
                    
                }
                .padding(20)
                .padding(.top, .topInsets + 60)

            }
            
            VStack {
                    
                HStack{
                    
                    Button {
                        presentMode.wrappedValue.dismiss()
                    } label: {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                    
                    Spacer()
                    
                    Text( "Change Password")
                        .font(.customFont(.bold, fontSize: 20))
                        .frame(height: 46)
                    Spacer()
                    
                    

                }
                .padding(.top, .topInsets)
                .padding(.horizontal, 20)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.2),  radius: 2 )
                
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

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
