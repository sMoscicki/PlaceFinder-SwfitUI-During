//
//  SwiftUIView.swift
//  Placesearch
//
//  Created by s.Moscicki on 14/05/2023.
//

import SwiftUI

struct BusinessRow: View {
    
    @ObservedObject var business: Business
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            ZStack{
                Rectangle()
                    .frame(width: 350 , height: 75)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .foregroundColor(.white)
                
                HStack{
                    let uiImage = UIImage(data: business.imageData ?? Data())
                    
                    Image(uiImage: uiImage ?? UIImage())
                        .resizable()
                        .aspectRatio(16/9, contentMode: .fill)
                        .frame(width: 65, height: 65)
                        .cornerRadius(10)
                    
                    VStack(alignment: .leading){
                        Text(business.name ?? "")
                            .bold()
                            .lineLimit(2)
                        Text(String(format: "%.1f km away", (business.distance ?? 0)/1000))
                            .font(.caption)
                    }
                    Spacer()
                    
                    VStack(alignment: .leading){
                        Image("regular_\(business.rating ?? 0)")
                        Text("\(String(business.reviewCount ?? 0)) Reviews")
                            .font(.caption)
                    }
                    Divider()
                    
                }
                .padding([.leading, .horizontal], 30)
            }
        }
    }
}

