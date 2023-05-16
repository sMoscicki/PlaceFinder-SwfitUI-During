//
//  CategoryListView.swift
//  Placesearch
//
//  Created by s.Moscicki on 16/05/2023.
//

import SwiftUI

struct CategoryListView: View {
        
    @EnvironmentObject var model: ContentModel
    
    var category: String
    
    var body: some View {
        
        NavigationView{
            VStack{
                ScrollView(showsIndicators: false){
                    LazyVStack{
                        
                        switch category {
                        case "all":
                            
                            Text("Restaurant")
                                .font(Font.custom("OktaItalic", size: 20))
                                .bold()
                            
                            ForEach(model.restaurant){ business in
                                NavigationLink(destination: BusinessDetail(business: business), label: {
                                    
                                        BusinessRow(business: business)
                                })
                            }
                            
                            Divider()
                            
                            Text("Sight")
                                .font(Font.custom("OktaItalic", size: 20))
                                .bold()
                           
                            ForEach(model.sight){ business in
                                NavigationLink(destination: BusinessDetail(business: business), label: {
                                     
                                        BusinessRow(business: business)
                                    
                                })
                            }
                            
    
                        case "restaurant":
                            ForEach(model.restaurant){ business in
                                NavigationLink(destination: BusinessDetail(business: business), label: {
                                    
                                    BusinessRow(business: business)
                                    
                                })
                            }
                        case "sight":
                            ForEach(model.sight){ business in
                                NavigationLink(destination: BusinessDetail(business: business), label: {
                                    
                                    BusinessRow(business: business)
                                    
                                })
                            }
                        default:
                            Text("Soon")
                        }
                        
                    }
                    .padding(.bottom, 80)
                    .padding(.top, 20)
                }
            }
            .background(Color("TabBarColor").opacity(0.4))
        }
        .navigationBarBackButtonHidden(true)
    }
}
