//
//  AccountRow.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 12/03/2025.
//

import SwiftUI

struct AccountRow: View {
    
    @State var title = "Order"
    @State var icon = "a_order"
    var body: some View {
        
        VStack{
            HStack(spacing:15){
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20,height: 20)
                Text(title)
                    .font(.customFont(.semibold, fontSize: 18))
                    .foregroundColor(.primaryText)
                    .frame(maxWidth: .infinity,alignment:.leading)
                Image("back")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20,height: 20)
                
            }
            Divider()
        }
        .padding(20)
    }
}

struct AccountRow_Previews: PreviewProvider {
    static var previews: some View {
        AccountRow()
    }
}
