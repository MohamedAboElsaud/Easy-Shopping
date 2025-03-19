//
//  SeeAllItems.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 19/03/2025.
//

import SwiftUI

struct SeeAllItems: View {
    
    @Environment(\.presentationMode) var presentMode: Binding<PresentationMode>

    @StateObject var homeVM = HomeViewModel.shared
    @State var array: [ProductModel]?
    var columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    

    var body: some View {
        ZStack{
            VStack {
                
                HStack{
                    
                    EmptyView()
                        .frame(width: 40, height: 40)
                    
                    Button{
                        presentMode.wrappedValue.dismiss()
                    }label: {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25,height: 25)
                    }
                    
                    Spacer()
                    
                    Text("All items")
                        .font(.customFont(.bold, fontSize: 20))
                        .frame(height: 46)
                    Spacer()
                    
                    
                    
                }
                .padding(.top, .topInsets)
                .padding(.horizontal, 20)
                
                
                                
                ScrollView {
                    LazyVGrid(columns: columns,  spacing:15) {
                        if array != nil{
                            ForEach(array!, id: \.id) {
                                pObj in
                                ProductCell( pObj: pObj ) {
                                    CartViewModel.serviceCallAddToCart(prodId: pObj.prodId, qty: 1) { isDone, msg in
                                        
                                        self.homeVM.alertMessage = msg
                                        self.homeVM.showAlert = true
                                    }
                                }
                            }

                        }
                    }
                    .padding(.vertical, 10)
                    .padding(.bottom, .bottomInsets + 60)
                }
            }
           // .padding(.top, .topInsets)
            .padding(.horizontal, 20)
        }
        .alert(isPresented: $homeVM.showAlert, content: {
            Alert(title: Text(Globs.AppName), message: Text(homeVM.alertMessage), dismissButton: .default(Text("OK")) )
        })
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

struct SeeAllItems_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SeeAllItems()
        }
    }
}
