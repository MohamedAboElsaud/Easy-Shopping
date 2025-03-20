//
//  SignInView.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 14/02/2025.
//

import SwiftUI
import CountryPicker

struct SignInView: View {
    @State var textFieldMobile = ""
    @State var isShowPicker:Bool = false
    @State var countryPickerObject: Country?
    var body: some View {
        //TODO: update this views

        ZStack{
            Image("bottom_bg")
                .resizable()
                .scaledToFill()
                .frame(width: .screenWidth,height: .screenHeight)
            
            VStack{
                Image("sign_in_top")
                    .resizable()
                    .scaledToFill()
                    .frame(width: .screenWidth,height: .screenWidth)
                Spacer()
            }
            ScrollView{
                
                VStack(alignment: .leading){
                    Text("Get your Shoping\nwith our store")
                        .font(.customFont(.semibold, fontSize: 26))
                        .foregroundColor(.primaryText)
                        .frame(minWidth: 0,maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                        .padding(.bottom,25)
                    
//                    HStack{
//                        Button {
//                            isShowPicker = true
//                        } label: {
//
//                            if let countryPickerObject = countryPickerObject{
//
//                                Text("\(countryPickerObject.isoCode.getFlag())")
//                                    .font(.customFont(.medium, fontSize: 18))
//
//                                Text("+\(countryPickerObject.phoneCode)")
//                                    .font(.customFont(.medium, fontSize: 18))
//                                    .foregroundColor(.primaryText)
//
//                            }
//
//                        }
//
//                        TextField("enter your mobile", text: $textFieldMobile)
//                            .frame(minWidth: 0,maxWidth: .infinity)
//
//                    }
                    
                    
                    NavigationLink {
                        LoginView()
                    } label: {
                        Text("Continue with Email Sign In")
                            .font(.customFont(.semibold, fontSize: 18))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                    .background(Color(hex: "5383EC"))
                    .cornerRadius(20)
                    .padding(.bottom, 8)
                    
                    NavigationLink {
                        SignUpView()
                    } label: {
                        Text("Continue with Email Sign Up")
                            .font(.customFont(.semibold, fontSize: 18))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                    .background(Color.primaryApp)
                    .cornerRadius(20)
                    .padding(.bottom, 8)


                    
                    Divider()
                        .padding(.bottom,25)
                    
                    Text("Or connectwith social media")
                        .font(.customFont(.semibold, fontSize: 14))
                        .foregroundColor(.textTitle)
                        .frame(minWidth: 0,maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                        .padding(.bottom,25)
                    
                    Button {
                        //TODO: add code to sign with google

                    } label: {
                        Image("google_logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20,height: 20)
                        Text("Continue with google")
                            .font(.customFont(.semibold, fontSize: 18))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                    .background(Color(hex: "5383EC"))
                    .cornerRadius(20)
                    .padding(.bottom, 8)
                    
                    Button {
                        //TODO: add code to sign with FaceBook

                    } label: {
                        Image("fb_logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20,height: 20)
                        Text("Continue with Facebook")
                            .font(.customFont(.semibold, fontSize: 18))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                    .background(Color(hex: "4A66AC"))
                    .cornerRadius(20)
                    
                    
                   
                }
                .padding(.horizontal,20)
                .frame(width: .screenWidth,alignment: .leading)
                .padding(.top,.topInsets + .screenWidth * 0.6 )
                
                
                
            }
            
        }
        .onAppear{
            self.countryPickerObject = Country(phoneCode: "20", isoCode: "EG")
        }
        .sheet(isPresented: $isShowPicker, content: {
            CountryPickerUI(country: $countryPickerObject)
        })
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SignInView()

        }
    }
}
