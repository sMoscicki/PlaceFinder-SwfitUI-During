import Foundation
import CoreLocation


class ContentModel: NSObject, CLLocationManagerDelegate, ObservableObject{
    
    @Published var restaurant = [Business]()
    @Published var sight = [Business]()
    @Published var boating = [Business]()
    @Published var gym = [Business]()
    @Published var paintball = [Business]()
    @Published var football = [Business]()
    @Published var waterPark = [Business]()
    @Published var barber = [Business]()
    
    var locationManager = CLLocationManager()
    
    override init(){
        
        super.init()
        
        locationManager.delegate = self
        
        //Request permission from the User
        locationManager.requestWhenInUseAuthorization()
        
        //TODO: Start geolocating the User
        //locationManager.startUpdatingLocation()
  
    }
    
    //MARK: - Location manager delegate methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        if locationManager.authorizationStatus == .authorizedAlways ||
            locationManager.authorizationStatus == .authorizedWhenInUse{
            
            // we have permision
            
            locationManager.startUpdatingLocation()
            
        }else if locationManager.authorizationStatus == .denied{
            // We dont have permision
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //Gives us the location of the User
        print(locations.first ?? "no location")
        
        //TODO: If we have the coordinates of the user, send into Yelp Api
        let userLocation = locations.first
        
        if userLocation != nil {
            
            
            //Stop requesting the location after we get it once
            locationManager.stopUpdatingLocation()
            
            getBusiness(category: Constants.restaurantKey, location: userLocation!)
            getBusiness(category: Constants.sightsKey, location: userLocation!)
            getBusiness(category: Constants.boatingKey, location: userLocation!)
            getBusiness(category: Constants.gymsKey, location: userLocation!)
            getBusiness(category: Constants.paintballKey, location: userLocation!)
            getBusiness(category: Constants.footballKey, location: userLocation!)
            getBusiness(category: Constants.waterparksKey, location: userLocation!)
            getBusiness(category: Constants.barbersKey, location: userLocation!)
        }
 
    }
    
    //MARK: - Yelp Api
    
    func getBusiness(category: String, location: CLLocation){
        
        //Create URL
        
        //Method 1
                
                /*
                let urlString = "https://api.yelp.com/v3/businesses/search?latitude=\(location.coordinate.latitude)&longitude=\(location.coordinate.longitude)&categories=\(category)&limit=6"
                let url = URL(string: urlString)
                */
        
        //Method 2
        var urlComponents = URLComponents(string: Constants.apiUrl)
        urlComponents?.queryItems = [

            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: category),
            URLQueryItem(name: "limit", value: "20")

        ]
        
        let url = urlComponents?.url
        
        if url != nil {
            
            //Create a URL Request
            var request = URLRequest(url: url! , cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 20.0)
            request.httpMethod = "GET"
            request.addValue("Bearer \(Constants.apiKey)", forHTTPHeaderField: "Authorization")
            
            //Create URLSession
            let session = URLSession.shared
            
            //Create Data Task
            let dataTask = session.dataTask(with: request){ data, response, error in
                
                //Check that there isnt an error
                if error == nil{
                    
                    do{
                        
                        let result = try JSONDecoder().decode(BusinessSearch.self, from: data!)
                        
                        //Sort businesses
                        var businesses = result.businesses
                        businesses.sort{ (b1, b2) -> Bool in
                            return b1.distance ?? 0 < b2.distance ?? 0
                            
                        }
                        
                        DispatchQueue.main.async {
                            switch category{
                            case Constants.restaurantKey:
                                self.restaurant = businesses
                            case Constants.sightsKey:
                                self.sight = businesses
                            case Constants.boatingKey:
                                self.boating = businesses
                            case Constants.gymsKey:
                                self.gym = businesses
                            case Constants.paintballKey:
                                self.paintball = businesses
                            case Constants.footballKey:
                                self.football = businesses
                            case Constants.waterparksKey:
                                self.waterPark = businesses
                            case Constants.barbersKey:
                                self.barber = businesses
                            default:
                                break
                            }
                        }
                       
                    }catch{
                        print("Error \(error)")
                    }
    
                }
                
            }
            dataTask.resume()
            
            
        }
        
    }
}
