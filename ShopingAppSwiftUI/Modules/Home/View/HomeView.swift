//
//  HomeView.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 19/02/2025.
//


import SwiftUI

struct HomeView: View {
    @StateObject var homeVM = HomeViewModel.shared
    
    var body: some View {
        ZStack{
            ScrollView{
                VStack{
                    Image("color_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25)
                    
                    HStack{
                        Image("location")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16 )
                        
                        Text("Cairo, Egypt")
                            .font(.customFont(.semibold, fontSize: 18))
                            .foregroundColor(.darkGray)
                    }
                    
                    SearchTextField(textField: $homeVM.textFieldSearch, placeholder: "Search Store")
                        .padding(.horizontal,20)
                        .padding(.vertical,10)
                }
                .padding(.top, .topInsets )
                
                Image("banner_top")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 115)
                    .padding(.horizontal, 20)
                
                // I create array for backend not have offer_list
                    
                
                NavigationLink {
                    SeeAllItems(array: homeVM.listArr.shuffled())
                } label: {
                    SectionTitleAll(title: "Exclusive offer", titleAll: "See All") {
                        
                    }
                    
                }
                
                .padding(.horizontal, 20)
                
                ScrollView(.horizontal, showsIndicators: false ) {
                    LazyHStack(spacing: 15) {
                        // TODO: update offerList
                        ForEach (homeVM.listArr, id: \.id) {
                            pObj in
                            ProductCell(pObj: pObj, didAddCart: {
                                CartViewModel.serviceCallAddToCart(prodId: pObj.prodId, qty: 1) { isDone, msg in
                                    
                                    self.homeVM.alertMessage = msg
                                    self.homeVM.showAlert = true
                                }
                            })
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 4)
                }
                
                
                NavigationLink {
                    SeeAllItems(array: homeVM.bestArr)
                } label: {
                    SectionTitleAll(title: "Best Selling", titleAll: "See All") {
                        
                    }
                    
                }
                .padding(.horizontal, 20)
                
                ScrollView(.horizontal, showsIndicators: false ) {
                    LazyHStack(spacing: 15) {
                        ForEach (homeVM.bestArr, id: \.id) {
                            pObj in
                            
                            ProductCell(pObj: pObj, didAddCart: {
                                CartViewModel.serviceCallAddToCart(prodId: pObj.prodId, qty: 1) { isDone, msg in
                                    
                                    self.homeVM.alertMessage = msg
                                    self.homeVM.showAlert = true
                                }
                            })
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 4)
                }
                NavigationLink {
                    SeeAllItems(array: homeVM.listArr)
                } label: {
                    SectionTitleAll(title: "Groceries", titleAll: "See All") {
                        
                    }
                    
                }
                .padding(.horizontal, 20)
                
                ScrollView(.horizontal, showsIndicators: false ) {
                    LazyHStack(spacing: 15) {
                        ForEach (homeVM.typeArr, id: \.id) {
                            tObj in
                            
                            CategoryCell(tObj: tObj) {
                                
                            }
                        }
                        
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 4)
                }
                .padding(.bottom, 8)
                
                ScrollView(.horizontal, showsIndicators: false ) {
                    LazyHStack(spacing: 15) {
                        ForEach (homeVM.listArr, id: \.id) {
                            pObj in
                            
                            ProductCell(pObj: pObj, didAddCart: {
                                CartViewModel.serviceCallAddToCart(prodId: pObj.prodId, qty: 1) { isDone, msg in
                                    
                                    self.homeVM.alertMessage = msg
                                    self.homeVM.showAlert = true
                                }
                            })
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 4)
                }
                .padding(.bottom, .bottomInsets + 60)
                
            }
        }
        .alert(isPresented: $homeVM.showAlert, content: {
            Alert(title: Text(Globs.AppName), message: Text(homeVM.alertMessage), dismissButton: .default(Text("OK")) )
        })
        .ignoresSafeArea()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
        }
    }
}
