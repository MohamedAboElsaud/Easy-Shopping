//
//  ShopingAppSwiftUIApp.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 14/02/2025.
//

import SwiftUI

@main
struct ShopingAppSwiftUIApp: App {
    
    @StateObject var mainVM = MainViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                if mainVM.isUserLogin{
                    MainTabView()
                }else{
                    WelcomeView()
                }
                
            }
        }
    }
}
