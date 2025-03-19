//
//  ForgotPasswordSetView.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 17/03/2025.
//


import SwiftUI

struct ForgotPasswordSetView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var forgotVM = ForgotPasswordViewModel.shared;
    
    
    var body: some View {
        ZStack {
            Image("bottom_bg")
            .resizable()
            .scaledToFill()
            .frame(width: .screenWidth, height: .screenHeight)
            
            
            VStack{
                
                
                
                Image("color_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
                    .padding(.bottom, .screenWidth * 0.1)
                
                
                Text("Set New Password")
                    .font(.customfont(.semibold, fontSize: 26))
                    .foregroundColor(.primaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 4)
                
                Text("Enter your new password")
                    .font(.customfont(.semibold, fontSize: 16))
                    .foregroundColor(.secondaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, .screenWidth * 0.1)
                
                
                LineSecureField(txt:$forgotVM.txtNewPassword, isPassword: $forgotVM.isNewPassword, title: "New Password", placeholder: "Enter your new password")
                    .padding(.bottom, .screenWidth * 0.02)
                
                LineSecureField(  txt: $forgotVM.txtConfirmPassword, isPassword: $forgotVM.isConfirmPassword,title: "Confirm Password", placeholder: "Enter your confirm password")
                    .padding(.bottom, .screenWidth * 0.04)
                
                
                RoundButton(title: "Submit") {
                    forgotVM.serviceCallSetPassword()
                }
                .padding(.bottom, .screenWidth * 0.05)
                
                
                
                
                Spacer()
            }
            .padding(.top, .topInsets + 64)
            .padding(.horizontal, 20)
            .padding(.bottom, .bottomInsets)
            
            
            VStack {
                    
                HStack {
                    Button {
                        mode.wrappedValue.dismiss()
                    } label: {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                    
                    Spacer()

                }
                
                Spacer()
                
            }
            .padding(.top, .topInsets)
            .padding(.horizontal, 20)
            
            
            
        }
        .alert(isPresented: $forgotVM.showError) {
            // TODO: create binding state to change value to dissmis all navigatios
            Alert(title: Text(Globs.AppName), message: Text( forgotVM.errorMessage ), dismissButton: .default(Text("Ok")))
        }
        
        .background(Color.white)
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
        
    }
}

struct ForgotPasswordSetView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordSetView()
    }
}
