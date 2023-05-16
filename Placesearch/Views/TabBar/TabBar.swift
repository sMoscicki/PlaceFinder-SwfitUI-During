//
//  TabBar.swift
//  Placesearch
//
//  Created by s.Moscicki on 12/05/2023.
//

import SwiftUI

struct TabBar: View {
    
    @State var selectTab = "Category"
    
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    let tabs = ["Home", "Category", "Map", "Profile"]
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            TabView(selection: $selectTab){
                HomeView(selectedCategory: .mostRated)
                        .tag("Home")
                CategoryView(listSelected: "all")
                        .tag("Category")
                    BusinessMap()
                        .tag("Map")
                    Text("coming soon")
                        .tag("Profile")
                  
            }
            .environmentObject(ContentModel())
            .environmentObject(CategoryListModel())
            
            
            
            HStack{
                ForEach(tabs, id: \.self){ tab in
                        Spacer()
                        TabBarItem(tab: tab, selected: $selectTab)
                        Spacer()
                }
            }
            .padding(.top, 20)
            .padding(.bottom, 5)
            .frame(maxWidth: .infinity)
            .background(Color("TabBarColor"))
            
        }
    }
}

struct TabBarItem: View{
    @State var tab: String
    @Binding var selected: String
    var body: some View{
        if tab == "Profile"{
            
            Button{
                withAnimation(.spring()){
                    selected = tab
                }
            }label: {
                ZStack{
                    Circle()
                        .frame(width: 35, height: 35)
                        .foregroundColor(selected == tab ? .green : Color("TabBarColor"))
                    
                    Image("Profile")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                }
            }
        }else{
            ZStack{
                Button{
                    withAnimation(.spring()){
                        selected = tab
                    }
                } label: {
                    HStack{
                        Image(tab)
                            .resizable()
                            .frame(width: 30, height: 30)
                        if selected == tab{
                            Text(tab)
                                .font(.system(size: 14))
                                .foregroundColor(.black)
                        }
                    }
                }
            }
            .opacity(selected == tab ? 1 : 0.7)
            .padding(.vertical, 5)
            .padding(.horizontal, 17)
            .background(selected == tab ? .white : Color("TabBarColor"))
            .clipShape(Capsule())
        }
        
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
