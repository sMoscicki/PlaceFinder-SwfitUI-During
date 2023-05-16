//
//  DataServices.swift
//  Placesearch
//
//  Created by s.Moscicki on 16/05/2023.
//

import Foundation

class DataService{
    
    //Parse local json
    
    func getLocalData() -> [CategoryBusinessList]{
        
        let pathString = Bundle.main.path(forResource: "data", ofType: "json")
        
        guard pathString != nil else{
            return [CategoryBusinessList]()
        }
        
        
        let url = URL(filePath: pathString!)
        
        do{
            
            let data = try Data(contentsOf: url)
            
            do{
                
                let categoryData = try JSONDecoder().decode([CategoryBusinessList].self, from: data)
                
                return categoryData
                
            }catch{
                print("Parse Local JSON: - ERROR: \(error)")
            }
            
        }catch{
            print("Parse Local JSON: - ERROR WITH GETTING DATA: \(error)")
        }
        
        return [CategoryBusinessList]()
        
    }
}
