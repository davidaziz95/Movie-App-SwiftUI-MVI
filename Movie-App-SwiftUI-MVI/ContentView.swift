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
            HomeView().navigationTitle(Constants.homePage).navigationBarTitleDisplayMode(.large)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
