//
//  NotificationView.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 16/03/2025.
//

import SwiftUI

struct NotificationView: View {
    @Environment(\.presentationMode) var presentMode: Binding<PresentationMode>
    
    @StateObject var notificationViewModel = NotificationViewModel.shared
    
    
    var body: some View {
        ZStack{
            
            ScrollView{
                LazyVStack(spacing: 15) {
                    ForEach( notificationViewModel.listArr , id: \.id, content: {
                        nObj in
                        
                        
                        VStack{
                            HStack {
                                Text(nObj.title)
                                    .font(.customFont(.bold, fontSize: 14))
                                    .foregroundColor(.primaryText)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                
                                
                                Text(nObj.createdDate.displayDate(format: "yyyy-MM-dd hh:mm a"))
                                    .font(.customFont(.regular, fontSize: 12))
                                    .foregroundColor(.secondaryText)
                                
                            }
                            
                       
                                
                                Text(nObj.message)
                                    .font(.customFont(.medium, fontSize: 14))
                                    .foregroundColor(.primaryText)
                                    .multilineTextAlignment( .leading)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                
                            }
                         
                        .padding(15)
                        .background( nObj.isRead == 1 ? Color.placeholder : Color.white)
                        .cornerRadius(5)
                        .shadow(color: Color.black.opacity(0.15), radius: 2)
                       


                    })
                }
                .padding(20)
                .padding(.top, .topInsets + 46)
                .padding(.bottom, .bottomInsets + 60)

            }
            
            
            VStack {
                    
                HStack{
                    
                    Button {
                        presentMode.wrappedValue.dismiss()
                    } label: {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }

                    
                   
                    Spacer()
                    
                    Text("Notification")
                        .font(.customFont(.bold, fontSize: 20))
                        .frame(height: 46)
                    Spacer()
                    
                    
                    Button {
                        
                        notificationViewModel.serviceCallReadAll()
                    } label: {
                        Text("Read All")
                            .font(.customFont(.bold, fontSize: 16))
                            .foregroundColor(.primaryApp)
                    }

                    
                    

                }
                .padding(.top, .topInsets)
                .padding(.horizontal, 20)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.2),  radius: 2 )
                
                Spacer()
                
            }
            
            
            
        }
        .alert(isPresented: $notificationViewModel.showAlert) {
            Alert(title: Text(Globs.AppName), message: Text(notificationViewModel.alertMessage), dismissButton: .default(Text("Ok")))
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
