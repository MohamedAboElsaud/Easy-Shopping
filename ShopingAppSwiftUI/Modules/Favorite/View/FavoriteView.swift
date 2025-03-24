//
//  FavoriteView.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 09/03/2025.
//

import SDWebImageSwiftUI
import SwiftUI

struct FavoriteView: View {
    @StateObject var favVM = FavoriteViewModel.shared
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack {
                    ForEach(favVM.listArr, id: \.self) {
                        fObj in

                        FavoriteRow(fObj: fObj)
                    }
                }
                .padding(20)
                .padding(.top, .topInsets + 60)
                .padding(.bottom, .bottomInsets + 60)
            }
            VStack {
                HStack {
                    Spacer()
                    Text("Favorites")
                        .font(.customFont(.bold, fontSize: 20))
                        .frame(height: 46)
                    Spacer()

                    //                    Button{
                    //
                    //                    }label: {
                    //                        Image("back")
                    //                            .resizable()
                    //                            .scaledToFit()
                    //                            .frame(width: 25,height: 25)
                    //                    }
                    //                    Spacer()
                    //
                    //                    Button{
                    //                    }label: {
                    //                        Image("share")
                    //                            .resizable()
                    //                            .scaledToFit()
                    //                            .frame(width: 25,height: 25)
                    //                    }
                }
                .padding(.top, .topInsets)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.2), radius: 2)

                Spacer()
                RoundButton(title: "Add All To Cart")
                    .padding(.horizontal, 20)
                    .padding(.bottom, .bottomInsets + 60)
            }
        }
        .onAppear {
            favVM.serviceCallList()
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
