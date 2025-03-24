//
//  FavoriteRow.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 09/03/2025.
//

import SDWebImageSwiftUI
import SwiftUI

struct FavoriteRow: View {
    @State var fObj = ProductModel(dict: [:])
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                WebImage(url: URL(string: fObj.image))
                    .resizable()
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .scaledToFit()
                    .frame(width: 100, height: 80)

                VStack(spacing: 4) {
                    Text(fObj.name)
                        .font(.customFont(.bold, fontSize: 16))
                        .foregroundColor(.primaryText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("\(fObj.unitValue)\(fObj.unitName) , price")
                        .font(.customFont(.medium, fontSize: 14))
                        .foregroundColor(.secondaryText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                Text("\(fObj.offerPrice ?? fObj.price, specifier: "%.2f")")
                    .font(.customFont(.semibold, fontSize: 18))
                    .foregroundColor(.primaryText)

                Image("next")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
            }
            Divider()
        }
    }
}

struct FavoriteRow_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteRow()
    }
}
