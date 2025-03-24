//
//  PromoCodeView.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 13/03/2025.
//

import SwiftUI

struct PromoCodeView: View {
    @Environment(\.presentationMode) var presentMode: Binding<PresentationMode>

    @StateObject var promoCodeViewModel = PromoCodeViewModel.shared
    @State var isPicker: Bool = false
    var didSelect: ((_ obj: PromoCodeModel) -> Void)?

    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack(spacing: 15) {
                    ForEach(promoCodeViewModel.listArr, id: \.id, content: {
                        pObj in

                        VStack {
                            HStack {
                                Text(pObj.title)
                                    .font(.customFont(.bold, fontSize: 14))
                                    .foregroundColor(.primaryText)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)

                                Text(pObj.code)
                                    .font(.customFont(.bold, fontSize: 15))
                                    .foregroundColor(.primaryApp)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 2)
                                    .background(Color.secondaryText.opacity(0.3))
                                    .cornerRadius(5)
                            }

                            Text(pObj.description)
                                .font(.customFont(.medium, fontSize: 14))
                                .foregroundColor(.secondaryText)
                                .multilineTextAlignment(.leading)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)

                            HStack {
                                Text("Expiry Date:")
                                    .font(.customFont(.bold, fontSize: 14))
                                    .foregroundColor(.primaryText)
                                    .padding(.vertical, 8)

                                Text(pObj.endDate.displayDate(format: "yyyy-MM-dd hh:mm a"))
                                    .font(.customFont(.bold, fontSize: 12))
                                    .foregroundColor(.secondaryText)
                                    .padding(.vertical, 8)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding(15)
                        .background(Color.white)
                        .cornerRadius(5)
                        .shadow(color: Color.black.opacity(0.15), radius: 2)
                        .onTapGesture {
                            if isPicker {
                                presentMode.wrappedValue.dismiss()
                                didSelect?(pObj)
                            }
                        }

                    })
                }
                .padding(20)
                .padding(.top, .topInsets + 46)
                .padding(.bottom, .bottomInsets + 60)
            }

            VStack {
                HStack {
                    Button {
                        presentMode.wrappedValue.dismiss()
                    } label: {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }

                    Spacer()

                    Text("Promo Code")
                        .font(.customFont(.bold, fontSize: 20))
                        .frame(height: 46)
                    Spacer()
                }
                .padding(.top, .topInsets)
                .padding(.horizontal, 20)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.2), radius: 2)

                Spacer()
            }
        }
        .onAppear {}
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

struct PromoCodeView_Previews: PreviewProvider {
    static var previews: some View {
        PromoCodeView()
    }
}
