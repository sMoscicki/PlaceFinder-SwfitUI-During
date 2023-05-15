//
//  CategoryView.swift
//  Placesearch
//
//  Created by s.Moscicki on 12/05/2023.
//

import SwiftUI

struct CategoryView: View {
    
    let category = ["restaurant", "sight", "boating", "football", "gym", "paintball", "waterpark", "barber"]
    
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVStack{
                    
                    ForEach(category, id: \.self){ category in
                        
                       NavigationLink(destination: {
                           BusinessList()
                       }, label: {
                           ZStack{
                               Image(category)
                                   .resizable()
                                   .aspectRatio(16/9, contentMode: .fill)
                                   .frame(width: 350, height: 100)
                                   .cornerRadius(10)
                                   .shadow(radius: 10)
                               
                               Text(category)
                                   .font(.largeTitle).textCase(.uppercase)
                                   .bold()
                                   .foregroundColor(.white)
                           }
                       })
                    
                    }
                }
            }
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
