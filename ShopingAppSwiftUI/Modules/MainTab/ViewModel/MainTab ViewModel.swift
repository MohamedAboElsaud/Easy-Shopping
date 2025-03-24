//
//  MainTab ViewModel.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 18/03/2025.
//

import SwiftUI

class MainTabViewModel: ObservableObject {
    static var shared: MainTabViewModel = .init()

    @Published var selectTab: Int = 0
}
