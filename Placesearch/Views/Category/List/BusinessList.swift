//
//  BusinessList.swift
//  Placesearch
//
//  Created by s.Moscicki on 12/05/2023.
//

import SwiftUI

struct BusinessList: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVStack{
                    Text("Restaurants")
                        .font(.system(.largeTitle))
                    ForEach(model.restaurant){ business in
                        NavigationLink(destination: BusinessDetail(business: business), label: {
                            
                            BusinessRow(business: business)
                            
                        })
                        
                    }
                    
                    Text("Sights")
                        .font(.system(.largeTitle))
                    
                    ForEach(model.sight){ business in
                        NavigationLink(destination: BusinessDetail(business: business), label: {
                            
                            BusinessRow(business: business)
                            
                        })
                        
                        
                        
                    }
                }
            }
            .padding(.bottom, 60)
        }
        .accentColor(.black)
        
    }
}

struct BusinessList_Previews: PreviewProvider {
    static var previews: some View {
        BusinessList()
            .environmentObject(ContentModel())
    }
}
