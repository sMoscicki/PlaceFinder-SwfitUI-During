//
//  ContentView.swift
//  Placesearch
//
//  Created by s.Moscicki on 10/05/2023.
//

import SwiftUI

struct LaunchView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
