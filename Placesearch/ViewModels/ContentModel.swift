import Foundation
import CoreLocation

class ContentModel: NSObject, CLLocationManagerDelegate, ObservableObject{
    
        @Published var restaurant = [Business]()
        @Published var sight = [Business]()
        @Published var boating = [Business]()
//        @Published var gym = [Business]()
//        @Published var paintball = [Business]()
//        @Published var football = [Business]()
//        @Published var waterPark = [Business]()
//        @Published var barber = [Business]()
    
    var locationManager = CLLocationManager()
    
    @Published var authorizationState = CLAuthorizationStatus.notDetermined
    
   override init(){
       
       // init method of NSObject
       super.init()
        
        //set content model as the delagate of the location manager
        locationManager.delegate = self
        
        //Request permision from the User
        locationManager.requestWhenInUseAuthorization()
        
        //Start geolocating the User, after we ger permission
        //locationManager.startUpdatingLocation()
    }
    
    func requestGeolocationPermission() {
          
          // Request permission from the user
          locationManager.requestWhenInUseAuthorization()
      }
    
    
    // MARK: Location Manager Delegate Methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        // update the authorization property
        
        authorizationState = locationManager.authorizationStatus
        
        if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse {
            
            //We have permission
            
            //Start geolocating the User, after we ger permission
            locationManager.startUpdatingLocation()
            
        }else if locationManager.authorizationStatus == .denied{
            
            //We dont have permission
            
            
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Give location of the User
        
        let userLocation = locations.first
        print(locations.first ?? "no location")
        
        if userLocation != nil {
            
            //Have location
            
            //Stop requesting the location after we get it once
            locationManager.stopUpdatingLocation()
            
            //MARK: Yelp API
            getBusinesses(category: Constants.restaurantKey, location: userLocation!)
            getBusinesses(category: Constants.sightsKey, location: userLocation!)
//            getBusinesses(category: Constants.boatingKey, location: userLocation!)
//            getBusinesses(category: Constants.gymsKey, location: userLocation!)
//            getBusinesses(category: Constants.paintballKey, location: userLocation!)
//            getBusinesses(category: Constants.footballKey, location: userLocation!)
//            getBusinesses(category: Constants.waterparksKey, location: userLocation!)
//            getBusinesses(category: Constants.barbersKey, location: userLocation!)
        }
      
    }
    
    //MARK: Yelp Api methods
    
    func getBusinesses(category: String, location: CLLocation){
        
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
        
        if let url = url {
            
        
            //Create URL Request
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.addValue("Bearer \(Constants.apiKey)", forHTTPHeaderField: "Authorization")
            //Create URLSession
            let sesion = URLSession.shared
            
            //Create Data Task
            let dataTask = sesion.dataTask(with: request) { data, response, error in
                
                //Check that there isnt an error
                if error == nil{
                    
                    //Parse json
                    do{
                        
                        let decode = JSONDecoder()
                        
                        let result = try decode.decode(BusinessSearch.self, from: data!)
                        
                        //Sort businesses
                        var businesses = result.businesses
                        businesses.sort { (b1, b2) -> Bool in
                            return b1.distance ?? 0 < b2.distance ?? 0
                            
                        }
                        
                        
                        // Call the get image function of the business
                        for b in businesses{
                            b.getImageData()
                        }
                        
                        DispatchQueue.main.async {
                            switch category{
                                
                            case Constants.restaurantKey:
                                self.restaurant = businesses
                            case Constants.sightsKey:
                                self.sight = businesses
//                            case Constants.boatingKey:
//                                self.boating = businesses
//                            case Constants.gymsKey:
//                                self.gym = businesses
//                            case Constants.paintballKey:
//                                self.paintball = businesses
//                            case Constants.footballKey:
//                                self.football = businesses
//                            case Constants.waterparksKey:
//                                self.waterPark = businesses
//                            case Constants.barbersKey:
//                                self.barber = businesses
                                default:
                                    break
                            }
                        }
                            
                    }
                    catch{
                        print(error)
                    }
                    
                }
            }
            //Start the Data Task
            dataTask.resume()
            
        }
    }
    
}
