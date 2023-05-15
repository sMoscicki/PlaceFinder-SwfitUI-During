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
            
        VStack{
            
            Text(String(business.name!.prefix(17)))
                .font(.caption)
            
            Image(uiImage: uiImage ?? UIImage())
                .resizable()
                .cornerRadius(10)
                .shadow(radius: 10)
                .frame(width: 100, height: 100)
                .aspectRatio(contentMode: .fit)
            
            Text(String(format: "%.1f km away", (business.distance ?? 0)/1000))
                .font(.caption)
            
        }
                        
    }
}

