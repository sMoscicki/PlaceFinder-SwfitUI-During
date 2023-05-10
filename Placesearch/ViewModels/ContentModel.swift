import Foundation
import CoreLocation


class ContentModel: NSObject, CLLocationManagerDelegate, ObservableObject{
    
    var locationManager = CLLocationManager()
    
    override init(){
        
        super.init()
        
        locationManager.delegate = self
        
        //Request permission from the User
        locationManager.requestWhenInUseAuthorization()
        
        //TODO: Start geolocating the User
        //locationManager.startUpdatingLocation()
  
    }
    
    //MARK - Location manager delegate methods
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
        
        //Stop requesting the location after we get it once
        locationManager.stopUpdatingLocation()
    }
    
}
