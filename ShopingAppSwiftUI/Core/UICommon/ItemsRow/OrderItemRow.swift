//
//  OrderItemRow.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 15/03/2025.
//


import SwiftUI
import SDWebImageSwiftUI

struct OrderItemRow: View {
    @State var pObj: OrderItemModel = OrderItemModel(dict: [:])
    var showReviewBotton = false
    var didTap: ( ()->() )?
    
    var body: some View {
            
        VStack {
            
       
            HStack(spacing: 15){
                WebImage(url: URL(string: pObj.image ))
                    .resizable()
                    .indicator(.activity) // Activity Indicator
                    .transition(.fade(duration: 0.5))
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                
                VStack(spacing: 4){
                    
                    Text(pObj.name)
                        .font(.customFont(.bold, fontSize: 16))
                        .foregroundColor(.primaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    Text("\(pObj.unitValue)\(pObj.unitName), price")
                        .font(.customFont(.medium, fontSize: 14))
                        .foregroundColor(.secondaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 8)
                    
                    HStack {
                        Text("QTY:")
                            .font(.customFont(.bold, fontSize: 16))
                            .foregroundColor(.primaryText)
                        
                        Text("\( pObj.qty )")
                            .font(.customFont(.bold, fontSize: 16))
                            .foregroundColor(.primaryText)
                        
                        Text("×")
                            .font(.customFont(.bold, fontSize: 16))
                            .foregroundColor(.primaryText)
                        
                        Text("$ \( pObj.itemPrice, specifier: "%.2f" )")
                            .font(.customFont(.bold, fontSize: 16))
                            .foregroundColor(.primaryText)
                        
                        
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                }
                
                Text("$\(pObj.offerPrice ?? pObj.price, specifier: "%.2f" )")
                    .font(.customFont(.semibold, fontSize: 18))
                    .foregroundColor(.primaryText)
                
                
            }
            
            if showReviewBotton {
                RoundButton(title: "Write a review" ) {
                    didTap?()
                }
            }
           
            
        }
            .padding(15)
            .background(Color.white)
            .cornerRadius(5)
            .shadow(color: Color.black.opacity(0.15), radius: 2)
            .padding(.horizontal, 20)
            .padding(.vertical, 4)
        
    }
}

struct OrderItemRow_Previews: PreviewProvider {
    static var previews: some View {
        OrderItemRow()
    }
}
