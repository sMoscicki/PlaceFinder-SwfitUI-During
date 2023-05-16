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
    
    @State var selectedCategory: categoryList = .pickup
        
    var body: some View {
        

        NavigationView{
            VStack(spacing: 0){
                Picker("Category", selection: $selectedCategory){
                    Text("Delivery")
                        .font(Font.custom("OktaUltraLight", size: 20))
                        .tag(categoryList.delivery)
                    Text("Most Rated")
                        .font(Font.custom("OktaUltraLight", size: 20))
                        .tag(categoryList.mostRated)
                    Text("Pick Up")
                        .font(Font.custom("OktaUltraLight", size: 20))
                        .tag(categoryList.pickup)
                }
                .padding()
                .pickerStyle(.segmented)
                .foregroundColor(.white)
                .background(Color("TabBarColor"))
                
                ScrollView{
    
                    VStack(spacing: 1){
                        
                        if selectedCategory == .mostRated{
                            
                            ZStack{
                                Image("restaurantBackground1")
                                    .resizable()
                                    .frame(height: 200)
                                    .aspectRatio(16/9, contentMode: .fill)
                                
                                
                                VStack(alignment: .leading){
                                    Text("The best Restaurants and Sights in your area")
                                        .font(Font.custom("OktaItalic", size: 30))
                                        .bold()
                                        .foregroundColor(.white)
                                        .padding()
                                        
                                        
                                    
                                    Spacer()
                                }
                                .padding()
                                
                            }
                            
                            
                            HStack{
                                Text("Top Rated Restaurants")
                                    .font(Font.custom("OktaUltraLight", size: 25))
                                
                                Spacer()
                                
                                Image("colorStar")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                
                            }
                            .padding()
                            
                            
                            ScrollView(.horizontal, showsIndicators: false){
                                HStack(spacing: 15){
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
                                Text("Top Rated Sights")
                                    .font(Font.custom("OktaItalic", size: 25))
                                
                                Spacer()
                                
                                Image("telescope")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            }
                            .padding()
                            
                            ScrollView(.horizontal, showsIndicators: false){
                                HStack(spacing: 15){
                                    ForEach(model.sight){ business in
                                        
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
                            
                        }else if selectedCategory == .delivery{
                            
                            HStack{
                                Text("Delivery Available")
                                
                                Spacer()
                                
                                Image("delivery")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            }
                            .padding()
                            
                            
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
                            
                            
                            
                        }else if selectedCategory == .pickup{
                            Text("Soon")
                        }
                        
                        
                        Divider()
                        
                    }
                    
                    
                }
                .ignoresSafeArea()
                .padding(.bottom, 60)
                
            }
            .background(Color("TabBarColor").opacity(0.4))
        }
        .accentColor(.black)
        
    }
}

