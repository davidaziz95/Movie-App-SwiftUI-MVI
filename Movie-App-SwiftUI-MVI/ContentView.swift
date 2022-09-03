//
//  ContentView.swift
//  Movie-App-SwiftUI-MVI
//
//  Created by David Aziz [Pharma] on 03/09/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        
        TabView {
                HomeView()
            .tabItem { Label("Home", systemImage: "house.fill")}
            
                FavoriteView().navigationBarTitle("Favorites", displayMode: .inline)
            .tabItem { Label("Favorites", systemImage: "heart.fill")}
           
        }.accentColor(Color.blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
