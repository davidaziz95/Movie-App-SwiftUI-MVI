//
//  HomeView.swift
//  Movie-App-SwiftUI-MVI
//
//  Created by David Aziz [Pharma] on 03/09/2022.
//

import SwiftUI

struct HomeView: View {
    
    @State private var loading = true
    @ObservedObject var vm: HomePageViewModel = HomePageViewModel()
    
    var body: some View {
        
        Group { () -> AnyView in
            
            switch vm.uiState {
            
            case .Init, .Loading: return AnyView(ProgressView())
            case .NoResultsFound: return AnyView(Text("No matching movies found"))
            case .ApiError(let errorMessage): return AnyView(Text(errorMessage))
            
            case .Fetched(let moviesResult):
                return AnyView(ScrollView(.vertical, showsIndicators: false)
                               { VStack { ForEach(moviesResult.results) { movie in MovieCard(movie: movie) } } })
            }
        }.onAppear {
            if loading {
                Task { await  vm.loadMovies()}
                loading = false
            }
        }
    }
}
