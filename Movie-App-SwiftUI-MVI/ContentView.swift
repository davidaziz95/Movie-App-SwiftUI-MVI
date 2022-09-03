//
//  ContentView.swift
//  Movie-App-SwiftUI-MVI
//
//  Created by David Aziz [Pharma] on 03/09/2022.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            TabView {
                HomeView().tabItem { Label("Home", systemImage: "house.fill")}.navigationTitle("Home")
                FavoriteView().tabItem { Label("Favorites", systemImage: "heart.fill")}.navigationTitle("Favorites")
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
