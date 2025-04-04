//
//  WelcomeView.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 14/02/2025.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        ZStack {
            Image("welcom_bg")
                .resizable()
                .scaledToFill()
                .frame(width: .screenWidth, height: .screenHeight)
            VStack {
                Spacer()
                Image("app_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .padding(.bottom, 8)

                Text("Welcome\nto our store")
                    .font(.customFont(.semibold, fontSize: 48))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)

                Text("Get Your Shoping in as fast as one hour")
                    .foregroundColor(.white.opacity(0.7))
                    .font(.customFont(.medium, fontSize: 16))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 30)

                NavigationLink {
                    SignInView()
                } label: {
                    Text("Get Started")
                        .font(.customFont(.semibold, fontSize: 18))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                .background(Color.primaryApp)
                .cornerRadius(20)

                Spacer()
                    .frame(height: 100)
            }
            .padding(.horizontal, 20)
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WelcomeView()
        }
    }
}
