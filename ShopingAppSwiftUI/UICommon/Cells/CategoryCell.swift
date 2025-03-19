//
//  CategoryCell.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 19/02/2025.
//

import SwiftUI
import SDWebImageSwiftUI
struct CategoryCell: View {
    @State var tObj = TypeModel(dict: [:])
    @State var color = Color.yellow
    var didAddCart:(()->())?
    var body: some View {
        
        HStack{
            WebImage(url: URL(string: tObj.image))
                .resizable()
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFit()
                .frame(width: 70,height: 70)
            
            Text(tObj.name)
                .font(.customfont(.bold, fontSize: 16))
                .foregroundColor(.primaryText)
                .frame(maxWidth: .infinity,alignment: .leading)
            
        }
        .padding(15)
        .frame(width: 250,height: 100)
        .background(tObj.color.opacity(0.3))
        .cornerRadius(15)
        
    }
}
struct CategoryCell_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCell()
    }
}
