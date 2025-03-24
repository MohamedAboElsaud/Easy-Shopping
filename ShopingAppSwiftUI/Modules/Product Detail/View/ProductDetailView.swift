//
//  ProductDetailView.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 22/02/2025.
//

import SDWebImageSwiftUI
import SwiftUI

struct ProductDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var detailVM: ProductDetailViewModel = .init(prodObj: ProductModel(dict: [:]))

    var body: some View {
        ZStack {
            ScrollView {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color(hex: "F2F2F2"))
                        .frame(width: .screenWidth, height: .screenWidth * 0.8)
                        .cornerRadius(20, corner: [.bottomLeft, .bottomRight])

                    WebImage(url: URL(string: detailVM.pObj.image))
                        .resizable()
                        .indicator(.activity)
                        .transition(.fade(duration: 0.5))
                        .scaledToFit()
                        .frame(width: .screenWidth * 0.8, height: .screenWidth * 0.8)
                }
                .frame(width: .screenWidth, height: .screenWidth * 0.8)

                VStack {
                    HStack {
                        Text(detailVM.pObj.name)
                            .font(.customFont(.bold, fontSize: 24))
                            .foregroundColor(.primaryText)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Button {
                            // detailVM.isFav.toggle()
                            detailVM.serviceCallAddRemoveFav()
                        } label: {
                            Image((detailVM.isFav) ? "favorite" : "fav")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                        }
                        .foregroundColor(Color.secondaryText)
                    }

                    Text("\(detailVM.pObj.unitValue)\(detailVM.pObj.unitName) , price")
                        .font(.customFont(.semibold, fontSize: 16))
                        .foregroundColor(.secondaryText)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    HStack {
                        Button {
                            detailVM.addSubQTY(isAdd: false)
                        } label: {
                            Image("subtack")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .padding(15)
                        }

                        Text("\(detailVM.qty)")
                            .font(.customFont(.bold, fontSize: 24))
                            .foregroundColor(.primaryText)
                            .multilineTextAlignment(.center)
                            .frame(width: 45, height: 45, alignment: .center)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.placeholder.opacity(0.5), lineWidth: 1)
                            )

                        Button {
                            detailVM.addSubQTY(isAdd: true)
                        } label: {
                            Image("add_green")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .padding(15)
                        }

                        Spacer()

                        Text("$\((detailVM.pObj.offerPrice ?? detailVM.pObj.price) * Double(detailVM.qty), specifier: "%.2f")")
                            .font(.customFont(.bold, fontSize: 24))
                            .foregroundColor(.primaryText)
                    }
                    .padding(.vertical, 8)
                    Divider()
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 20)

                VStack {
                    HStack {
                        Text("Product Detail")
                            .font(.customFont(.semibold, fontSize: 16))
                            .foregroundColor(.primaryText)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Button {
                            withAnimation {
                                detailVM.isShowDetail.toggle()
                            }
                        } label: {
                            Image(detailVM.isShowDetail ? "detail_open" : "next")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15, height: 15)
                                .padding(15)
                        }
                        .foregroundColor(Color.primaryText)
                    }

                    if detailVM.isShowDetail {
                        Text("\(detailVM.pObj.detail)")
                            .font(.customFont(.medium, fontSize: 13))
                            .foregroundColor(.secondaryText)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 8)
                    }
                    Divider()
                }
                .padding(.horizontal, 20)

                VStack {
                    HStack {
                        Text("Nutritions")
                            .font(.customFont(.semibold, fontSize: 16))
                            .foregroundColor(.primaryText)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Text(detailVM.pObj.nutritionWeight)
                            .font(.customFont(.semibold, fontSize: 10))
                            .foregroundColor(.secondaryText)
                            .padding(8)
                            .background(Color.placeholder.opacity(0.5))
                            .cornerRadius(5)

                        Button {
                            withAnimation {
                                detailVM.isShowNutrition.toggle()
                            }
                        } label: {
                            Image(detailVM.isShowNutrition ? "detail_open" : "next")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15, height: 15)
                                .padding(15)
                        }
                        .foregroundColor(Color.primaryText)
                    }

                    if detailVM.isShowNutrition {
                        LazyVStack {
                            ForEach(detailVM.nutritionArr, id: \.self) { nObj in
                                HStack {
                                    Text(nObj.nutritionName)
                                        .font(.customFont(.semibold, fontSize: 15))
                                        .foregroundColor(.secondaryText)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text(nObj.nutritionValue)
                                        .font(.customFont(.semibold, fontSize: 15))
                                        .foregroundColor(.primaryText)
                                }
                                Divider()
                            }
                            .padding(.vertical, 0)
                        }
                        .padding(.horizontal, 10)
                    }
                    Divider()
                }
                .padding(.horizontal, 20)

                if detailVM.pObj.avgRating > 0 {
                    HStack {
                        Text("Review")
                            .font(.customFont(.semibold, fontSize: 16))
                            .foregroundColor(.primaryText)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        HStack(spacing: 2) {
                            ForEach(1 ... 5, id: \.self) { _ in
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(Color.orange)
                                    .frame(width: 20, height: 20)
                            }
                        }
                        Divider()

                        Button {
                            // TODO: complete code
                        } label: {
                            Image("back")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15, height: 15)
                                .padding(15)
                        }
                        .foregroundColor(Color.primaryText)
                    }
                    .padding(.horizontal, 20)
                }
                RoundButton(title: "Add to basket") {
                    CartViewModel.shared.serviceCallAddToCart(prodId: detailVM.pObj.prodId, qty: detailVM.qty) { _, message in
                        detailVM.qty = 1
                        self.detailVM.showAlert = true
                        self.detailVM.alertMessage = message
                    }
                }

                .padding(20)
            }

            VStack {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }
                    Spacer()

                    Button {} label: {
                        Image("share")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }
                }
                Spacer()
            }
            .padding(.top, .topInsets)
            .padding(.horizontal, 20)
        }
        .alert(isPresented: $detailVM.showAlert, content: {
            Alert(title: Text(Globs.AppName), message: Text(detailVM.alertMessage), dismissButton: .default(Text("Ok")))

        })
        .onAppear {}
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(detailVM: ProductDetailViewModel(prodObj: ProductModel(dict: [
            "prod_id": 5,
            "cat_id": 1,
            "brand_id": 1,
            "type_id": 1,
            "name": "Red Apple",
            "detail": "Apples contain key nutrients, including fiber and antioxidants. They may offer health benefits, including lowering blood sugar levels and benefitting heart health.",
            "unit_name": "kg",
            "unit_value": "1",
            "nutrition_weight": "182g",
            "price": 1.99,
            "image": "http://localhost:3001/img/product/202307310951365136W6nJvPCdzQ.png",
            "cat_name": "Frash Fruits & Vegetable",
            "type_name": "Pulses",
            "is_fav": 1,
            "avg_rating": 0,

        ])))
    }
}
