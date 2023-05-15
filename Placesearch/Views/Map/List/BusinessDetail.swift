//
//  BusinessDetail.swift
//  Placesearch
//
//  Created by s.Moscicki on 14/05/2023.
//

import SwiftUI

struct BusinessDetail: View {
    
    var business: Business
    
    func checkAvailableTransactions(checkTransactions: String) -> Bool {
        
        let text = business.transactions?.description ?? ""
        
        if text.contains(checkTransactions){
            return true
        }else{
            return false
        }
    }
  
    var body: some View {
        
        let uiImage = UIImage(data: business.imageData ?? Data())
        ScrollView{
            VStack{
                Image(uiImage: uiImage ?? UIImage())
                    .resizable()
                    .frame(width: 400, height: 400)
                    .cornerRadius(10)
            
                
                HStack{
                    VStack{
                        Text(business.name ?? "")
                            .bold()
                    }
                    
                    Spacer()
                    VStack(alignment: .leading){
                        Image("regular_\(business.rating ?? 0)")
                        Text("\(String(business.reviewCount ?? 0)) Reviews")
                    }
                }
                .padding()
                
                
                
                ZStack{
                    Rectangle()
                        .frame(height: 20)
                        .foregroundColor(.gray).opacity(0.7)
                        .cornerRadius(10)
                    
                    Text("Status".uppercased())
                        .font(.caption)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        
                }
                .padding()
                
                HStack{                    
                    ZStack{
                        Rectangle()
                            .clipShape(Circle())
                            .frame(width: 40, height: 40)
                            .foregroundColor(checkAvailableTransactions(checkTransactions: "pickup") ? .green : .red).opacity(0.5)
                        
                        Image("order")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 30, height: 30)
                            .clipShape(Circle())
                    }
                    ZStack{
                        Rectangle()
                            .clipShape(Circle())
                            .frame(width: 40, height: 40)
                            .foregroundColor(checkAvailableTransactions(checkTransactions: "delivery") ? .green : .red).opacity(0.5)
                        
                        Image("delivery")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 30, height: 30)
                            .clipShape(Circle())
                    }
 
                    Spacer()
                    
                    ZStack{
                        Rectangle()
                            .frame(width: 100, height: 50)
                            .foregroundColor((business.isClosed ?? true) ? .red : .green)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        
                        Text((business.isClosed ?? true) ? "Closed" : "Open")
                            .foregroundColor(.white)
                            
                        
                    }
                }
                .padding()
                
                Text(business.isClosed?.description ?? "")
                
                
                ZStack{
                    Rectangle()
                        .frame(height: 20)
                        .foregroundColor(.gray).opacity(0.7)
                        .cornerRadius(10)
                    
                    Text("informations".uppercased())
                        .font(.caption)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        
                }
                .padding()
                
                DisclosureGroup("Phone", content: {
                    HStack{
                        Text(business.phone ?? "")
                        Spacer()
                        Link("Call", destination: URL(string: "tel://\(business.phone ?? "")")!)
                    }
                    .accentColor(.blue)
                })
                .padding()
                
                DisclosureGroup("Web Site", content: {
                    HStack{
                        Spacer()
                        Link("Link", destination: URL(string: "\(String(business.url ?? ""))")!)
                    }
                    .accentColor(.blue)
                })
                .padding()
                
                if business.location?.address1 != nil{
                    DisclosureGroup("Adresses", content: {
                        Divider()
                        Text(business.location?.address1 ?? "")
                        Divider()
                        
                        if business.location?.address2 != "" && business.location?.address2 != nil{
                            Text(business.location?.address2 ?? "")
                            Divider()
                        }
                            if business.location?.address3 != "" && business.location?.address3 != nil{
                                Text(business.location?.address3 ?? "")
                                Divider()
                            }
                    })
                    .padding()
         
                }else{
                    Text("Brak adressow dostawy")
                }
       
            }
            .padding()
        }
        .padding(.bottom, 80)
    }
}
