//
//  ExploreCategoryCell.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 10/03/2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct ExploreCategoryCell: View{
    @State var cObj = ExploreCategoryModel(dict: [:])
    var didAddCart:(()->())?
    var body: some View {
        
        VStack{
            WebImage(url: URL(string: cObj.image))
                .resizable()
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFit()
                .frame(width: 120,height: 90)
            Spacer()
            Text(cObj.name)
                .font(.customfont(.bold, fontSize: 16))
                .foregroundColor(.primaryText)
                .frame(maxWidth: .infinity,alignment: .center)
            Spacer()
        }
        .padding(15)
        .background(cObj.color.opacity(0.3))
        .cornerRadius(15)
        .overlay(
        RoundedRectangle(cornerRadius: 16)
            .stroke(cObj.color,lineWidth: 1)
        )
        
    }
}

struct ExploreCategoryCell_Previews: PreviewProvider {
    static var previews: some View {
        ExploreCategoryCell(cObj: ExploreCategoryModel(dict: ["offer_price": 2.49,
                                                              "start_date": "2023-07-30T18:30:00.000Z",
                                                              "end_date": "2023-08-29T18:30:00.000Z",
                                                              "prod_id": 5,
                                                              "cat_id": 1,
                                                              "brand_id": 1,
                                                              "type_id": 1,
                                                              "name": "Organic Banana",
                                                              "detail": "banana, fruit of the genus Musa, of the family Musaceae, one of the most important fruit crops of the world. The banana is grown in the tropics, and, though it is most widely consumed in those regions, it is valued worldwide for its flavour, nutritional value, and availability throughout the year",
                                                              "unit_name": "pcs",
                                                              "unit_value": "7",
                                                              "nutrition_weight": "200g",
                                                              "price": 2.99,
                                                              "image": "http://192.168.1.3:3001/img/product/202307310947354735xuruflIucc.png",
                                                              "cat_name": "Frash Fruits & Vegetable",
                                                              "type_name": "Pulses",
                                                              "is_fav": 1]))
        .padding(20)
    }
}
