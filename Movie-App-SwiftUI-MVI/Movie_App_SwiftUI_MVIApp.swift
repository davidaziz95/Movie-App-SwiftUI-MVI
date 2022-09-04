//
//  Movie_App_SwiftUI_MVIApp.swift
//  Movie-App-SwiftUI-MVI
//
//  Created by David Aziz [Pharma] on 03/09/2022.
//

import SwiftUI

@main
struct Movie_App_SwiftUI_MVIApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationView{ HomeView()
                        .navigationViewStyle(.stack)
                        .navigationTitle("Home")
                        .navigationBarTitleDisplayMode(.large)
                }
                .tabItem { Label("Home", systemImage: "house.fill")}
                .navigationViewStyle(StackNavigationViewStyle())
                
                NavigationView{ FavoriteView()
                        .navigationViewStyle(.stack)
                        .navigationTitle("Favorites")
                        .navigationBarTitleDisplayMode(.large)
                }
                .tabItem { Label("Favorites", systemImage: "heart.fill") }
                .navigationViewStyle(StackNavigationViewStyle())
                
            }.accentColor(Color.blue)
        }
    }
}
