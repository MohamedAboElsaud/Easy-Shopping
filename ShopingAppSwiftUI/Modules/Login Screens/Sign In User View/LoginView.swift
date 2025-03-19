//
//  LoginView.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 15/02/2025.
//

import SwiftUI

struct LoginView: View {
    
    @Environment(\.presentationMode) var presentationMode
    // complete name
    @StateObject var loginVM = MainViewModel.shared
    
    var body: some View {
        ZStack{
            Image("bottom_bg")
                .resizable()
                .scaledToFill()
                .frame(width: .screenWidth,height: .screenHeight)
            
            VStack{
                Image("color_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
                    .padding(.bottom, .screenWidth * 0.1)
                
                
                Text("Loging")
                    .font(.customFont(.semibold, fontSize: 26))
                    .foregroundColor(.primaryText)
                    .frame(maxWidth: .infinity,alignment:.leading)
                    .padding(.bottom,4)
                
                Text("Enter your email and password")
                    .font(.customFont(.semibold, fontSize: 16))
                    .foregroundColor(.secondaryText)
                    .frame(maxWidth: .infinity,alignment:.leading)
                    .padding(.bottom, .screenWidth * 0.1)
                
                LineTextField(textField: $loginVM.textFieldEmail, title: "Email", placeholder: "Enter your email address",keyboardType: .emailAddress)
                    .padding(.bottom,.screenWidth * 0.07)
                
                LineSecureField(textField: $loginVM.textFieldPassword, isPassword: $loginVM.isShowPassword, title: "Password", placeholder: "Enter your Password")
                    .padding(.bottom,.screenWidth * 0.02)

                
            NavigationLink {
                    ForgotPasswordView()
                } label: {
                    Text("Forgot Password?")
                        .font(.customFont(.medium, fontSize: 14))
                        .foregroundColor(.primaryText)
                    
                }
                .frame(maxWidth: .infinity,alignment:.trailing)
                .padding(.bottom,.screenWidth * 0.03)

                RoundButton(title: "Log In") {
                    loginVM.serviceCallLogin()
                }
                .padding(.bottom,.screenWidth * 0.05)

                
                NavigationLink {
                    //TODO: don't duplicate screens
                  //  presentationMode.wrappedValue.dismiss()
                    SignUpView()
                } label: {
                    HStack{
                        Text("Don't have an account?")
                            .font(.customFont(.semibold, fontSize: 14))
                            .foregroundColor(.primaryText)
                        Text("Sign Up")
                            .font(.customFont(.semibold, fontSize: 14))
                            .foregroundColor(.primaryApp)
                    }
                }

                
                Spacer()
            }
            .padding(.top, .topInsets + 64)
            .padding(.horizontal,20)
            .padding(.bottom, .bottomInsets)
            
            VStack{
                
                HStack{
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20,height: 20)
                    }
                    Spacer()

                }
                Spacer()
            }
            .padding(.top, .topInsets)
            .padding(.horizontal,20)
                
        }
        .alert(isPresented: $loginVM.showAlert, content: {
            Alert(title: Text(Globs.AppName),message: Text(loginVM.alertMessage),dismissButton: .default(Text("Ok")))
        })
        .background(Color.white)
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginView()
        }
    }
}
