//
//  LineTextField.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 15/02/2025.
//

import SwiftUI

struct LineTextField: View {
    @Binding var txt:String
    @State var title = "title"
    @State var placeholder = "placeholder"
    @State var keyboardType: UIKeyboardType = .default
    @State var isPassword = false
    
    var body: some View {
        VStack{
            Text(title)
                .font(.customfont(.semibold, fontSize: 16))
                .foregroundColor(.textTitle)
                .frame(minWidth: 0,maxWidth: .infinity,alignment:.leading)
            
            
            TextField(placeholder, text: $txt)
                .frame(height: 40)
                .keyboardType(keyboardType)
                .autocapitalization(.none)
                .autocorrectionDisabled(true)
            
            
            Divider()
            
            
        }
    }
}


struct LineSecureField: View {
    @Binding var txt:String
    @Binding var isPassword: Bool
    @State var title = "title"
    @State var placeholder = "placeholder"
    
    var body: some View {
        VStack{
            Text(title)
                .font(.customfont(.semibold, fontSize: 16))
                .foregroundColor(.textTitle)
                .frame(minWidth: 0,maxWidth: .infinity,alignment:.leading)
            
            if isPassword{
                TextField(placeholder, text: $txt)
                    .autocorrectionDisabled(true)
                    .autocapitalization(.none)
                    .frame(height: 40)
                    .modifier(ShowButton(isShow: $isPassword))
                
            }else{
                SecureField(placeholder, text: $txt)
                    .autocapitalization(.none)
                    .frame(height: 40)
                    .modifier(ShowButton(isShow: $isPassword))
            }
            
            Divider()
            
            
        }
    }
}


struct LineTextField_Previews: PreviewProvider {
    @State static var txt = ""
    static var previews: some View {
        LineTextField(txt: $txt)
            .padding(20)
    }
}
