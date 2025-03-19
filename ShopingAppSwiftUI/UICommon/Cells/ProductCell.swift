//
//  ProductCell.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 19/02/2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductCell: View {
    @State var pObj = ProductModel(dict: [:])
    var didAddCart:(()->())?
    var body: some View {
        NavigationLink {
            ProductDetailView(detailVM: ProductDetailViewModel(prodObj: pObj))
        } label: {
            VStack{
                WebImage(url: URL(string: pObj.image))
                    .resizable()
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .scaledToFit()
                    .frame(width: 100,height: 80)
                
                Spacer()
                Text(pObj.name)
                    .font(.customfont(.bold, fontSize: 16))
                    .foregroundColor(.primaryText)
                    .frame(maxWidth: .infinity,alignment: .leading)
                Text("\(pObj.unitValue)\(pObj.unitName) , price")
                    .font(.customfont(.medium, fontSize: 14))
                    .foregroundColor(.secondaryText)
                    .frame(maxWidth: .infinity,alignment: .leading)
                
                if pObj.avgRating > 0 {
                    
                    HStack(spacing: 2) {
                        ForEach(1...5, id: \.self) {
                            index in
                            
                            Image(systemName: "star.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor( index <= pObj.avgRating ? Color.orange : Color.black.opacity(0.2))
                                .frame(width: 15, height: 15)
                            }
                    }
                    .frame(maxWidth: .infinity,alignment: .leading)

                    
                } else {
                    Spacer()
                }
                
                HStack{
                    Text("\(pObj.offerPrice ?? pObj.price, specifier: "%.2f")")
                        .font(.customfont(.semibold, fontSize: 18))
                        .foregroundColor(.primaryText)
                        .frame(maxWidth: .infinity,alignment: .leading)
                    Spacer()
                    
                    Button{
                        didAddCart?()
                    }label: {
                        Image("add")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15,height: 15)
                    }
                    .frame(width: 40,height: 40)
                    .background(Color.primaryApp)
                    .cornerRadius(15)
                }
            }
            .padding(15)
            .frame(width: 180,height: 230)
            .overlay (
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.placeholder.opacity(0.5), lineWidth: 1)
            )
            
        }
        
    }
}

struct ProductCell_Previews: PreviewProvider {
    static var previews: some View {
        ProductCell(pObj: ProductModel(dict: ["offer_price": 2.49,
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
                                                      "is_fav": 1])) {
                    
                }
    }
}
