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
                return AnyView(
                    List(moviesResult.results, id: \.id) { movie in
                        NavigationLink {
                            MovieDetails(movie: movie)
                        } label: {
                            MovieCard(movie: movie)
                        } .buttonStyle(BorderlessButtonStyle())
                    }.listStyle(.plain)
                )
            }
        }
        .searchable(text: $vm.searchQuery.currentValue, prompt: "Find a movie")
        .onChange(of: vm.searchQuery.debouncedValue) { newValue in
            if newValue.isEmpty { vm.loadMovies() }
            else { vm.searchMovies() }
        }
    }
}
