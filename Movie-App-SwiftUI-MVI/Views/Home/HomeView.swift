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
                    List {
                        ForEach(moviesResult.results) { movie in
                            ZStack {
                                MovieCard(movie: movie)
                                NavigationLink {
                                    MovieDetails(movie: movie)
                                } label: {
                                    EmptyView()
                                }.opacity(0)
                            }
                        }
                    }
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
