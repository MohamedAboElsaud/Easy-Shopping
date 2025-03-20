//
//  AccountView.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 12/03/2025.
//

import SwiftUI

struct AccountView: View {
    @StateObject var accountViewModel = AccountDetailsViewModel.shared
    var order = MyOrdersView()
    
    var body: some View {
        ZStack{
            VStack{
                ScrollView{
                    LazyVStack{
                        
                        Image("sprof2")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 90,height: 90)
                            .padding(.top,.topInsets+10)
                            .cornerRadius(30)
                        HStack{
                            let name = accountViewModel.textFieldName
                            Text(name == "" ? "User" : name)
                                .font(.customFont(.bold, fontSize: 39))
                                .foregroundColor(.primaryApp)
                                .frame(maxWidth: .infinity,alignment:.center)
                                .padding(.bottom,1)
                                .padding(.horizontal,20)
                        }

                        HStack{
                            let email = accountViewModel.textFieldUsername
                            Text(email == "" ? "Email" : email)
                                .font(.customFont(.medium, fontSize: 18))
                                .accentColor(.secondaryText)
                                .frame(maxWidth: .infinity,alignment:.center)
                                .padding(.horizontal,20)
                            
                        }
                        
                        VStack{
                            
                            NavigationLink {
                                MyOrdersView()
                            } label: {
                                
                                AccountRow(title: "My Orders", icon: "a_order")
                            }
                            
                            
                            NavigationLink {
                                MyDetailsView()
                            } label: {
                                
                                AccountRow(title: "My Details", icon: "a_my_detail")
                            }
                            
                            
                            NavigationLink {
                                DelieryAddressView()
                            } label: {
                                
                                AccountRow(title: "Delivery Address", icon: "a_delivery_address")
                            }
                            
                            NavigationLink {
                                PaymentMethodsView()
                            } label: {
                                
                                AccountRow(title: "Payment Methods", icon: "paymenth_methods")
                            }
                            NavigationLink {
                                PromoCodeView()
                            } label: {
                                
                                AccountRow(title: "Promo Code", icon: "a_promocode")
                            }
                        }
                        VStack{
                            NavigationLink {
                                NotificationView()
                            } label: {
                                
                                AccountRow(title: "Notifications", icon: "a_noitification")
                            }
                            
                            //TODO: create screens for this views
                            AccountRow(title: "Help", icon: "a_help")
                            
                            AccountRow(title: "About", icon: "a_about")
                            
                        }
                    }
                }
                
                Spacer()
                
                Button {
                    MainViewModel.shared.logout()
                } label: {
                    ZStack{
                        
                        Text("Log out")
                            .font(.customFont(.semibold, fontSize: 18))
                            .foregroundColor(.primaryApp)
                            .multilineTextAlignment(.center)
                        HStack{
                            Spacer()
                            Image("logout")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .padding(.trailing,20)
                        }
                    }
                    
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                .background(Color(hex: "F2F3F2"))
                .cornerRadius(20)
                .padding(.horizontal,20)
                .padding(.bottom,20)
                
            }
            .padding(.bottom,.bottomInsets + 60)
        }
        .ignoresSafeArea()
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AccountView()
        }
    }
}
