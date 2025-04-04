//
//  ExploreItemsView.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 10/03/2025.
//

import SwiftUI

struct ExploreItemsView: View {
    @Environment(\.presentationMode) var presentMode: Binding<PresentationMode>
    @StateObject var itemsVM = ExploreItemViewModel(catObj: ExploreCategoryModel(dict: [:]))

    var columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15),
    ]

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    EmptyView()
                        .frame(width: 40, height: 40)

                    Button {
                        presentMode.wrappedValue.dismiss()
                    } label: {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }

                    Spacer()

                    Text("Category")
                        .font(.customFont(.bold, fontSize: 20))
                        .frame(height: 46)
                    Spacer()

                    Button(action: {
                        // TODO: add new category

                    }, label: {
                        Image("add_green")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    })
                    .frame(width: 40, height: 40)
                }
                .padding(.top, .topInsets)
                .padding(.horizontal, 20)

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(itemsVM.listArr, id: \.id) {
                            pObj in
                            ProductCell(pObj: pObj) {
                                CartViewModel.shared.serviceCallAddToCart(prodId: pObj.prodId, qty: 1) { _, msg in

                                    self.itemsVM.alertMessage = msg
                                    self.itemsVM.showAlert = true
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
        .alert(isPresented: $itemsVM.showAlert, content: {
            Alert(title: Text(Globs.AppName), message: Text(itemsVM.alertMessage), dismissButton: .default(Text("OK")))
        })
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

struct ExploreItemsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ExploreItemsView(itemsVM: ExploreItemViewModel(catObj: ExploreCategoryModel(dict: [
                "cat_id": 1,
                "cat_name": "Frash Fruits & Vegetable",
                "image": "http://192.168.1.3:3001/img/category/20230726155407547qM5gSxkrCh.png",
                "color": "53B175",
            ])))
        }
    }
}
