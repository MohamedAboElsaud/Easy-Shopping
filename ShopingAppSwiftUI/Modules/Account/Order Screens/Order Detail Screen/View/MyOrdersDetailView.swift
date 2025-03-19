//
//  MyOrdersDetailView.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 15/03/2025.
//


import SwiftUI
import SDWebImageSwiftUI

struct MyOrdersDetailView: View {
    @Environment(\.presentationMode) var presentMode: Binding<PresentationMode>
    @StateObject var myOrderDetailViewModel: MyOrderDetailViewModel = MyOrderDetailViewModel(prodObj: MyOrderModel(dict: [:]) )
    @State var showWriteReview = false
    
    var body: some View {
        ZStack{
            
            ScrollView {
                
                VStack{
                    HStack{
                        Text("Order ID: # \( myOrderDetailViewModel.pObj.id )")
                            .font(.customFont(.bold, fontSize: 20))
                            .foregroundColor(.primaryText)
                        
                        Spacer()
                        
                        Text( getPaymentStatus(mObj: myOrderDetailViewModel.pObj )  )
                            .font(.customFont(.bold, fontSize: 18))
                            .foregroundColor( getPaymentStatusColor(mObj: myOrderDetailViewModel.pObj))
                    }
                    
                    
                    HStack{
                        Text(myOrderDetailViewModel.pObj.createdDate.displayDate(format: "yyyy-MM-dd hh:mm a"))
                            .font(.customFont(.regular, fontSize: 12))
                            .foregroundColor(.secondaryText)
                        
                        Spacer()
                        
                        Text( getOrderStatus(mObj: myOrderDetailViewModel.pObj )  )
                            .font(.customFont(.bold, fontSize: 18))
                            .foregroundColor( getOrderStatusColor(mObj: myOrderDetailViewModel.pObj))
                    }
                    .padding(.bottom, 8)
                    
                    Text("\(myOrderDetailViewModel.pObj.address),\(myOrderDetailViewModel.pObj.city), \(myOrderDetailViewModel.pObj.state), \(myOrderDetailViewModel.pObj.postalCode) ")
                        .font(.customFont(.regular, fontSize: 16))
                        .foregroundColor(.secondaryText)
                        .multilineTextAlignment( .leading)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 8)
                    
                    HStack{
                        Text("Delivery Type:")
                            .font(.customFont(.medium, fontSize: 16))
                            .foregroundColor(.primaryText)
                        
                        Spacer()
                        
                        Text( getDeliveryType(mObj: myOrderDetailViewModel.pObj )  )
                            .font(.customFont(.regular, fontSize: 16))
                            .foregroundColor( .primaryText )
                    }
                    .padding(.bottom, 4)
                    
                    HStack{
                        Text("Payment Type:")
                            .font(.customFont(.medium, fontSize: 16))
                            .foregroundColor(.primaryText)
                        
                        Spacer()
                        
                        Text( getPaymentType(mObj: myOrderDetailViewModel.pObj )  )
                            .font(.customFont(.regular, fontSize: 16))
                            .foregroundColor( .primaryText )
                    }
                    
                    
                }
                .padding(15)
                .background(Color.white)
                .cornerRadius(5)
                .shadow(color: Color.black.opacity(0.15), radius: 2)
                .padding(.horizontal, 20)
                .padding(.top, .topInsets + 46)
                
                LazyVStack {
                    ForEach(myOrderDetailViewModel.listArr, id: \.id) { pObj in
                        OrderItemRow(pObj: pObj, showReviewBotton: myOrderDetailViewModel.pObj.orderStatus == 3 && pObj.rating == 0) {
                           // showWriteReview = true
                            myOrderDetailViewModel.actionWriteReviewOpen(obj: pObj)
                        }
                    }
                }
                
                VStack{
                                       
                    HStack{
                        Text("Amount:")
                            .font(.customFont(.bold, fontSize: 18))
                            .foregroundColor(.primaryText)
                        
                        Spacer()
                        
                        Text( "$\( myOrderDetailViewModel.pObj.totalPrice, specifier: "%.2f" )"  )
                            .font(.customFont(.medium, fontSize: 18))
                            .foregroundColor( .primaryText )
                    }
                    .padding(.bottom, 4)
                    
                    HStack{
                        Text("Delivery Cost:")
                            .font(.customFont(.bold, fontSize: 18))
                            .foregroundColor(.primaryText)
                        
                        Spacer()
                        
                        Text( "+ $\( myOrderDetailViewModel.pObj.deliverPrice ?? 0.0, specifier: "%.2f" )"  )
                            .font(.customFont(.medium, fontSize: 18))
                            .foregroundColor( .primaryText )
                    }
                    .padding(.bottom, 4)
                    
                    HStack{
                        Text("Discount Cost:")
                            .font(.customFont(.bold, fontSize: 18))
                            .foregroundColor(.primaryText)
                        
                        Spacer()
                        
                        Text( "- $\( myOrderDetailViewModel.pObj.discountPrice ?? 0.0, specifier: "%.2f" )"  )
                            .font(.customFont(.medium, fontSize: 18))
                            .foregroundColor( .red )
                    }
                    .padding(.bottom, 4)
                    
                    Divider()
                    
                    HStack{
                        Text("Total:")
                            .font(.customFont(.bold, fontSize: 22))
                            .foregroundColor(.primaryText)
                        
                        Spacer()
                        
                        Text( "$\( myOrderDetailViewModel.pObj.userPayPrice ?? 0.0, specifier: "%.2f" )"  )
                            .font(.customFont(.bold, fontSize: 22))
                            .foregroundColor( .primaryText )
                    }
                    .padding(.bottom, 4)
                    
                    
                }
                .padding(15)
                .background(Color.white)
                .cornerRadius(5)
                .shadow(color: Color.black.opacity(0.15), radius: 2)
                .padding(.horizontal, 20)
                .padding(.vertical, 4)
                
            }
            
            VStack {
                
                HStack{
                    Button {
                        presentMode.wrappedValue.dismiss()
                    } label: {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }
                    
                    Spacer()
                    
                    Text("My Order Detail")
                        .font(.customFont(.semibold, fontSize: 16))
                        .foregroundColor(.primaryText)
                    Spacer()
                    
                }
                
                Spacer()
            }
            .padding(.top, .topInsets)
            .padding(.horizontal, 20)
            
        }
        .alert(isPresented: $myOrderDetailViewModel.showAlert, content: {
            
            Alert(title: Text(Globs.AppName), message: Text(myOrderDetailViewModel.alertMessage)  , dismissButton: .default(Text("Ok"))  )
        })
        .background( NavigationLink(destination: WriteReviewView( myOrderDetailViewModel: myOrderDetailViewModel), isActive: $myOrderDetailViewModel.showWriteReview, label: {
            EmptyView()
        }) )
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
    
    func getOrderStatus(mObj: MyOrderModel) -> String {
        switch mObj.orderStatus {
        case 1:
            return "Placed"
        case 2:
            return "Accepted";
        case 3:
            return "Delivered";
        case 4:
            return "Cancel";
        case 5:
            return "Declined";
        default:
            return "";
        }
    }
    
    func getDeliveryType(mObj: MyOrderModel) -> String {
        switch mObj.deliverType {
        case 1:
              return "Delivery";
            case 2:
              return "Collection";
        default:
            return "";
        }
    }
    
    func getPaymentType(mObj: MyOrderModel) -> String {
        switch mObj.paymentType {
        case 1:
            return "Cash On Delivery";
        case 2:
            return "Online Card Payment";
        default:
            return "";
        }
    }
    
    func getPaymentStatus(mObj: MyOrderModel) -> String {
        switch mObj.paymentStatus {
        case 1:
            return "Processing";
        case 2:
            return "Success";
        case 3:
            return "Fail";
        case 4:
            return "Refunded";
        default:
            return "";
        }
    }
    
    func getPaymentStatusColor(mObj: MyOrderModel) -> Color {
        
        if (mObj.paymentType == 1) {
            return Color.orange;
        }
        
        switch mObj.paymentStatus {
        case 1:
            return Color.blue;
        case 2:
            return Color.green;
        case 3:
            return Color.red;
        case 4:
            return Color.green;
        default:
            return Color.white;
        }
    }
    
    func getOrderStatusColor(mObj: MyOrderModel) -> Color {
        
     
        
        switch mObj.orderStatus {
        case 1:
              return Color.blue;
            case 2:
              return Color.green;
            case 3:
              return Color.green;
            case 4:
              return Color.red;
            case 5:
              return Color.red;
            default:
              return Color.primaryApp;        }
    }
}

struct MyOrdersDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MyOrdersDetailView(myOrderDetailViewModel: MyOrderDetailViewModel(prodObj: MyOrderModel(dict: [
            
            
                        "order_id": 4,
                        "cart_id": "22,23",
                        "total_price": 10.450000000000001,
                        "user_pay_price": 11.405000000000001,
                        "discount_price": 1.0450000000000002,
                        "deliver_price": 2,
                        "deliver_type": 1,
                        "payment_type": 2,
                        "payment_status": 2,
                        "order_status": 1,
                        "status": 1,
                        "created_date": "2023-08-10T05:09:14.000Z",
                        "names": "Organic Banana,Red Apple",
                        "images": "http://localhost:3001/img/product/202307310947354735xuruflIucc.png,http://localhost:3001/img/product/202307310951365136W6nJvPCdzQ.png",
                        "user_name": "My Home",
                        "phone": "98765432102",
                        "address": "246/ A, Dhutpeshwar Bldg, Girgaon Road, Near Gai Wadi, Girgaon",
                        "city": "Mumbai",
                        "state": "Maharashtra",
                        "postal_code": "400004"
                    
            
        ])))
    }
}
