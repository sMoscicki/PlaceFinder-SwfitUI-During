//
//  CategoryView.swift
//  Placesearch
//
//  Created by s.Moscicki on 16/05/2023.
//

import SwiftUI

struct CategoryView: View {

    @EnvironmentObject var category: CategoryListModel

    @State var listSelected: String
    
    var body: some View {
        
            VStack{
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 20){
                        
                        ForEach(category.categoryListName){ category in
                            Button {
                                listSelected = category.listName
                            } label: {
                                VStack(spacing: 1){
                                    ZStack{
                                        if listSelected == category.listName{
                                            Circle()
                                                .frame(width: 55, height: 55)
                                                .foregroundColor(.green)
                                        }
                                        
                                        Circle()
                                            .frame(width: 50, height: 50)
                                            .foregroundColor(.white)
                                        Image(category.image)
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                    }
                                    
                                    Text(category.name)
                                        .font(Font.custom("OktaUltraLight", size: 12))
                                    
                                }
                            }
   
                        }
                    
                    }
                    .padding()
                }
                .environmentObject(CategoryListModel())
                
                CategoryListView(category: listSelected)
                
            }
            .accentColor(.black)
            .background(Color("TabBarColor").opacity(0.4))
    }
}
