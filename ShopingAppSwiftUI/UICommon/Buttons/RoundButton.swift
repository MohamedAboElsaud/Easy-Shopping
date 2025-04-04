//
//  RoundButton.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 14/02/2025.
//

import SwiftUI

struct RoundButton: View {
    @State var title = "title"
    var didTap: (() -> Void)?
    var body: some View {
        Button {
            didTap?()
        } label: {
            Text(title)
                .font(.customFont(.semibold, fontSize: 18))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
        .background(Color.primaryApp)
        .cornerRadius(20)
    }
}

struct RoundButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundButton()
            .padding(20)
    }
}
