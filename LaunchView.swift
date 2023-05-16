//
//  ContentView.swift
//  Placesearch
//
//  Created by s.Moscicki on 10/05/2023.
//

import SwiftUI

struct LaunchView: View {

    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        TabBar()
        
//        // Detect the authorization status of geolocating the user
//
//        if model.authorizationState == .notDetermined {
//            // If undetermined, show onboarding
//            OnboardingView()
//        }
//        else if model.authorizationState == .authorizedAlways ||
//                    model.authorizationState == .authorizedWhenInUse {
//            // If approved, show home view
//            TabBar()
//        }
//        else {
//            // If denied show denied view
//            LocationDeniedView()
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
