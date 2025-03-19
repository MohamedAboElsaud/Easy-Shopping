//
//  TabButton.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 19/02/2025.
//

import SwiftUI

struct TabButton: View {
    @State var title = "title"
    @State var icon = "store_tab"
    var isSelected = false
    var didSelected:(()->())
    var body: some View {
        
        Button{
            debugPrint("(tab button tap)")
            didSelected()
        }label: {
            VStack{
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25,height: 25)
                Text(title)
                    .font(.customfont(.semibold, fontSize: 14))
                
            }
        }
        .foregroundColor(isSelected ? .primaryApp : .primaryText)
        .frame(maxWidth: .infinity)
        
    }
}

struct TabButton_Previews: PreviewProvider {
    static var previews: some View {
        TabButton {
            print("test")
        }
    }
}
