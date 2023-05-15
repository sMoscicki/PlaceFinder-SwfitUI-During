//
//  HomeViewRow.swift
//  Placesearch
//
//  Created by s.Moscicki on 15/05/2023.
//

import SwiftUI

struct MostRatingView: View {
    
    var business: Business
  
    var body: some View {
        
            let uiImage = UIImage(data: business.imageData ?? Data())
            
        VStack(spacing: 2){
            
            ZStack{
                
                Image(uiImage: uiImage ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 325, height: 150)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                
                
                Text(String(business.name!.prefix(17)))
                    .font(Font.custom("OktaUltraLight", size: 30))
                    .foregroundColor(.white)
                    
            }
            HStack(spacing: 2){
                
                Image("like")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .shadow(radius: 10)
                
                Text("\(business.rating?.description ?? "")/5.0")
                    .font(Font.custom("OktaItalic", size: 15))
                    .shadow(radius: 10)
                
                
                Text("(\(String(business.reviewCount ?? 0)) Reviews)")
                    .foregroundColor(.gray).opacity(0.5)
                    .font(Font.custom("OktaItalic", size: 15))
                    .shadow(radius: 10)
                
                Spacer()
                
                Text(String(format: "%.1f km away", (business.distance ?? 0)/1000))
                    .font(Font.custom("OktaItalic", size: 12))
                    .shadow(radius: 10)
                
            }
            .padding()
            
            HStack{
                
                
            }
            
        }
                        
    }
}

