//
//  AddDeliveryAddressView.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 13/03/2025.
//

import SwiftUI

struct AddDeliveryAddressView: View {
    @StateObject var addressVM = DeliveryAddressViewModel.shared
    @Environment(\.presentationMode) var presentationMode : Binding<PresentationMode>
    @State var isEdit : Bool = false
    @State var editObj: AddressModel?
    
    var body: some View {
        ZStack{
            
            ScrollView{
                VStack(spacing:15){
                    HStack{
                        Button {
                            addressVM.txtName = "Home"
                        } label: {
                            Image(systemName: addressVM.txtName == "Home" ? "record.circle" : "circle")
                            Text("Home")
                                .font(.customfont(.medium, fontSize: 16))
                                .frame(maxWidth: .infinity,alignment:.leading)

                            
                        }
                        .foregroundColor(.primaryText)
                        Button {
                            addressVM.txtName = "Office"
                        } label: {
                            Image(systemName: addressVM.txtName == "Office" ? "record.circle" : "circle")
                            Text("Office")
                                .font(.customfont(.medium, fontSize: 16))
                                .frame(maxWidth: .infinity,alignment:.leading)
                            
                        }
                        .foregroundColor(.primaryText)
                        
                    }
                    .padding(.bottom,15)
                    
                    LineTextField(txt: $addressVM.txtName, title: "Name", placeholder: "Enter your name")
                    
                    LineTextField(txt: $addressVM.txtMobile, title: "Mobile", placeholder: "Enter your Mobile",keyboardType: .numberPad)
                    
                    LineTextField(txt: $addressVM.txtAddress, title: "Address Line", placeholder: "Enter your Address")
                    
                    HStack{
                        LineTextField(txt: $addressVM.txtCity, title: "City", placeholder: "Enter your city")
                        
                        LineTextField(txt: $addressVM.txtState, title: "State", placeholder: "Enter your State")
                    }
                    
                    LineTextField(txt: $addressVM.txtPostalCode, title: "Postal Code", placeholder: "Enter your postal code")

                    RoundButton(title: isEdit ? "Update Address" : "Add Address") {
                        if(isEdit){
                            addressVM.serviceCallUpdateAddress(aObj: editObj) {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }else{
                            addressVM.serviceCallAddAddress {
                                
                                self.presentationMode.wrappedValue.dismiss()
                            }
                            
                        }
                    }

                }
                .padding(20)
                .padding(.top,.topInsets + 46)
            }
            
            VStack {
                
                HStack{
                    
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                    Spacer()
                    
                    Text(isEdit ? "Edit Delivery Address" : "Add Delivery Address")
                        .font(.customfont(.bold, fontSize: 20))
                        .frame(height: 46)
                    Spacer()
                    
                }
                .padding(.top, .topInsets)
                .padding(.horizontal, 20)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.2),  radius: 2 )
                
                Spacer()
                
            }
        }
        .onAppear{
            if(isEdit){
                if let editObj = editObj{
                    addressVM.setData(aObj: editObj)
                }
            }
        }
        .alert(isPresented: $addressVM.showError) {
            Alert(title: Text(Globs.AppName),message: Text(addressVM.errorMessage),dismissButton: .default(Text( "Ok")))
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

struct AddDeliveryAddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddDeliveryAddressView()
    }
}
