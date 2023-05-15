//
//  HomeView.swift
//  Placesearch
//
//  Created by s.Moscicki on 15/05/2023.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentModel
    
    
    
    enum categoryList: String, CaseIterable, Identifiable{
        case mostRated, delivery, pickup
        var id: Self {self}
    }
    
    @State private var selectedCategory: categoryList = .mostRated
    
    var body: some View {
        
        NavigationView{
            ScrollView{
                VStack{
                    
                    Picker("Category", selection: $selectedCategory){
                        Text("Most Rated").tag(categoryList.mostRated)
                        Text("Delivery").tag(categoryList.delivery)
                        Text("Pick Up").tag(categoryList.pickup)
                    }
                    .padding()
                    .pickerStyle(.segmented)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                    
                    Divider()
                    
                    HStack{
                        Text("Top Rated Restaurants")
                        
                        Spacer()
                        
                        Image("colorStar")
                            .resizable()
                            .frame(width: 50, height: 50)
                        
                    }
                    .padding()
                    
                    Divider()
                    
                    ScrollView(.horizontal, showsIndicators: true){
                        HStack(spacing: 10){
                            ForEach(model.restaurant){ business in
                                
                                if business.rating! >= 4.0 {
                                    NavigationLink {
                                        BusinessDetail(business: business)
                                    } label: {
                                        MostRatingView(business: business)
                                    }
                                    
                                }
                                
                            }
                        }
                        .padding()
                    }
                    Divider()
                    
                    HStack{
                        Text("Delivery Available")
                        
                        Spacer()
                        
                        Image("delivery")
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                    .padding()
                    
                    Divider()
                    
                    ScrollView(.horizontal, showsIndicators: true){
                        HStack(spacing: 10){
                            ForEach(model.restaurant){ business in
                                
                                if (business.transactions?.description.contains("delivery") != nil){
                                    NavigationLink {
                                        BusinessDetail(business: business)
                                    } label: {
                                        DeliveryAvailableView(business: business)
                                    }
                                }
                                Divider()
                            }
                        }
                        .padding()
                    }
                    
                }
            }
        }
        .accentColor(.black)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
    }
}
