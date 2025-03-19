//
//  SignUpView.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 17/02/2025.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject  var mainVM = MainViewModel.shared
    
    var body: some View {
        
        ZStack{
            
            Image("bottom_bg")
                .resizable()
                .scaledToFit()
                .frame(width: .screenWidth, height: .screenHeight)
            
            ScrollView {
                VStack{
                    Image("color_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40)
                        .padding(.bottom, .screenWidth * 0.1)
                    
                    
                    Text("Sign Up")
                        .font(.customFont(.semibold, fontSize: 26))
                        .foregroundColor(.primaryText)
                        .frame(maxWidth: .infinity,alignment:.leading)
                        .padding(.bottom,4)
                    
                    Text("Enter your username , email and password")
                        .font(.customFont(.semibold, fontSize: 16))
                        .foregroundColor(.secondaryText)
                        .frame(maxWidth: .infinity,alignment:.leading)
                        .padding(.bottom, .screenWidth * 0.1)
                    
                    LineTextField(textField: $mainVM.textFieldUsername, title: "Username", placeholder: "Enter your username")
                        .padding(.bottom,.screenWidth * 0.07)
                    
                    LineTextField(textField: $mainVM.textFieldEmail, title: "Email", placeholder: "Enter your email address",keyboardType: .emailAddress)
                        .padding(.bottom,.screenWidth * 0.07)
                    
                    LineSecureField(textField: $mainVM.textFieldPassword, isPassword: $mainVM.isShowPassword, title: "Password", placeholder: "Enter your Password")
                        .padding(.bottom,.screenWidth * 0.04)
                    

                    VStack{
                        Text("By continue you agree to our privacy")
                            .font(.customFont(.medium, fontSize: 14))
                            .foregroundColor(.secondaryText)
                            .frame(maxWidth: .infinity)
                        HStack{
                            Text("Terms of Service")
                                .foregroundColor(Color.primaryApp)
                                .font(.customFont(.medium, fontSize: 14))
                            Text("and")
                                .foregroundColor(Color.secondaryText)
                                .font(.customFont(.medium, fontSize: 14))
                            Text("Privacy Policy")
                                .foregroundColor(Color.primaryApp)
                                .font(.customFont(.medium, fontSize: 14))
                        }
                        .padding(.bottom,.screenWidth * 0.02)
                    }
                    

                    RoundButton(title: "Sign Up") {
                        mainVM.serviceCalSignUp()
                    }
                    .padding(.bottom,.screenWidth * 0.05)

                    
                    NavigationLink {
                        LoginView()
                    } label: {
                        HStack{
                            Text("Already have an account?")
                                .font(.customFont(.semibold, fontSize: 14))
                                .foregroundColor(.primaryText)
                            Text("Sign In")
                                .font(.customFont(.semibold, fontSize: 14))
                                .foregroundColor(.primaryApp)
                        }
                    }

                    
                    Spacer()
                }
                .padding(.top, .topInsets + 64)
                .padding(.horizontal,20)
                .padding(.bottom, .bottomInsets)
            }
            
            VStack{
                HStack{
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image("back")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 20,height: 20,alignment: .leading)
                    }
                    Spacer()

                }
                Spacer()
            }
            .padding(.top,.topInsets)
            .padding(.horizontal,20)
        }
        .alert(isPresented: $mainVM.showAlert, content: {
            Alert(title: Text(Globs.AppName),message: Text(mainVM.alertMessage),dismissButton: .default(Text("Ok")))
        })
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
