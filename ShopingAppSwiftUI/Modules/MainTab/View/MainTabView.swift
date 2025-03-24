//
//  MainTabView.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 17/02/2025.
//

import SwiftUI

struct MainTabView: View {
    @StateObject var homeVM = MainTabViewModel.shared
    var body: some View {
        ZStack {
            switch homeVM.selectTab {
            case 0:
                HomeView()
            case 1:
                ExploreView()
            case 2:
                MyCartView()
            case 3:
                FavoriteView()
            case 4:
                AccountView()
            default:
                HomeView()
            }

            VStack {
                Spacer()
                HStack {
                    TabButton(title: "Shop", icon: "store_tab", isSelected: homeVM.selectTab == 0) {
                        DispatchQueue.main.async {
                            withAnimation {
                                homeVM.selectTab = 0
                            }
                        }
                    }
                    TabButton(title: "Explore", icon: "explore_tab", isSelected: homeVM.selectTab == 1) {
                        DispatchQueue.main.async {
                            withAnimation {
                                homeVM.selectTab = 1
                            }
                        }
                    }
                    TabButton(title: "Cart", icon: "cart_tab", isSelected: homeVM.selectTab == 2) {
                        DispatchQueue.main.async {
                            withAnimation {
                                homeVM.selectTab = 2
                            }
                        }
                    }
                    TabButton(title: "Favorite", icon: "fav_tab", isSelected: homeVM.selectTab == 3) {
                        DispatchQueue.main.async {
                            withAnimation {
                                homeVM.selectTab = 3
                            }
                        }
                    }
                    TabButton(title: "Account", icon: "account_tab", isSelected: homeVM.selectTab == 4) {
                        DispatchQueue.main.async {
                            withAnimation {
                                homeVM.selectTab = 4
                            }
                        }
                    }
                }
                .padding(.top, 10)
                .padding(.bottom, .bottomInsets)
                .padding(.horizontal, 10)
                .background(Color.white)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.15), radius: 3, x: 0, y: -2)
            }
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MainTabView()
        }
    }
}
