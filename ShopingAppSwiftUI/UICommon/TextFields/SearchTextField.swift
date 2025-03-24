//
//  SearchTextField.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 19/02/2025.
//

import SwiftUI

struct SearchTextField: View {
    @Binding var textField: String
    @State var placeholder = "placeholder"

    var body: some View {
        HStack(spacing: 15) {
            Image("search")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)

            TextField(placeholder, text: $textField)
                .font(.customFont(.regular, fontSize: 17))
                .autocorrectionDisabled(true)
                .autocapitalization(.none)
                .frame(maxWidth: .infinity)
        }
        .frame(height: 30)
        .padding(15)
        .background(Color(hex: "F2F3F2"))
        .cornerRadius(16)
    }
}

struct SearchTextField_Previews: PreviewProvider {
    @State static var textField = ""
    static var previews: some View {
        SearchTextField(textField: $textField, placeholder: "Search store")
            .padding(15)
    }
}
