//
//  HomeView.swift
//  Movie-App-SwiftUI-MVI
//
//  Created by David Aziz [Pharma] on 03/09/2022.
//

import SwiftUI

struct HomeView: View {
    
    @State private var loading = true
    @StateObject private var searchQuery = DebouncedState(initialValue: "")
    @ObservedObject var vm: HomePageViewModel = HomePageViewModel()
    
    var body: some View {
        Group { () -> AnyView in
            
            switch vm.uiState {
                
            case .Init, .Loading: return AnyView(ProgressView())
            case .NoResultsFound: return AnyView(Text("No matching movies found"))
            case .ApiError(let errorMessage): return AnyView(Text(errorMessage))
                
            case .Fetched(let moviesResult):
                return AnyView(
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVStack { ForEach(moviesResult.results) { movie in
                            NavigationLink {
                                MovieDetails(movie: movie)
                            } label: {
                                MovieCard(movie: movie)
                                Divider()
                            }.buttonStyle(FlatLinkStyle())
                        }
                        }
                    }
                )
            }
        }
        .searchable(text: $searchQuery.currentValue, prompt: "Find a movie")
        .onChange(of: searchQuery.debouncedValue) { newValue in
            if newValue.isEmpty { Task { await  vm.loadMovies()} }
            else { vm.searchMovies(query: searchQuery.debouncedValue) }
        }
        .onAppear {
            if loading {
                Task { await  vm.loadMovies()}
                loading = false
            }
        }
    }
}
