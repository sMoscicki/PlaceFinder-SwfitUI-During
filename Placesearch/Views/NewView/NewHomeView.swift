//
//  NewHomeView.swift
//  Placesearch
//
//  Created by s.Moscicki on 18/05/2023.
//

import SwiftUI

struct NewHomeView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        ZStack{
            Color.yellow.ignoresSafeArea()
            
            VStack{
                //MARK: - Header Hstack
                HStack(spacing: 15){
                    
                    //MARK: - Profile Button
                    
                    Button {
                        
                    } label: {
                        ZStack{
                            Circle()
                                .foregroundColor(.white).opacity(0.7)
                                .frame(width: 40, height: 40)
                                .shadow(radius: 10)
                            
                            Image(systemName: "person")
                                .accentColor(.black)
                                .bold()
                        }
                    }

                    //TODO: - Search
                    
                    ZStack{
                        Rectangle()
                            .foregroundColor(.white).opacity(0.7)
                            .frame(width: 250, height: 35)
                            .cornerRadius(20)
                            .shadow(radius: 5)
                        
                        Text("Coming soon")
                            .foregroundColor(.gray)
                        
                    }
                    
                    //MARK: - Profile Map Button
          
                    Button {
                        
                    } label: {
                        ZStack{
                            Circle()
                                .foregroundColor(.white).opacity(0.7)
                                .frame(width: 40, height: 40)
                                .shadow(radius: 10)
                            
                            Image(systemName: "map")
                                .accentColor(.black)
                                .bold()
                        }
                    }
                    
                }
                .padding()
                
         
                
                
            }
        }
        
        
        
    }

}

struct NewHomeView_Previews: PreviewProvider {
    static var previews: some View {
        NewHomeView()
            .environmentObject(ContentModel())
    }
}
