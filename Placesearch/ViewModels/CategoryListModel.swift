//
//  CategoryListModel.swift
//  Placesearch
//
//  Created by s.Moscicki on 16/05/2023.
//

import Foundation

class CategoryListModel: ObservableObject{
    
    @Published var categoryListName = [CategoryBusinessList]()
    
    init(){
        
        categoryListName.self = DataService().getLocalData()
        
    }
}
