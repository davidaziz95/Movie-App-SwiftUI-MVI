//
//  HomePageViewModel.swift
//  Movie-App-SwiftUI-MVI
//
//  Created by David Aziz [Pharma] on 03/09/2022.
//

import Combine
import Foundation

class HomePageViewModel: ObservableObject {
    
    let repository: HomePageRepoProtocol
    @Published var uiState: HomePageState = .Init
    
    @Published var searchQuery = DebouncedState(initialValue: "")
    private var disposables: Set<AnyCancellable> = []
    
    
    init(dataManager: HomePageRepoProtocol = HomePageRepo.shared) {
        self.repository = dataManager
        loadMovies()
    }
    
    func loadMovies() {
        self.uiState = .Loading
        
        repository.fetchMovies().sink { response in
            if response.error != nil {
                debugPrint(response.error!)
                self.uiState = .ApiError("Results could not be fetched")
            }
            else if (response.value!.results.isEmpty) { self.uiState = .NoResultsFound }
            else { self.uiState = .Fetched(response.value!) }
        }.store(in: &disposables)
    }
    
    
    func searchMovies() {
        self.uiState = .Loading
        
        repository.searchMovies(query: searchQuery.debouncedValue).sink { response in
            if response.error != nil {
                debugPrint(response.error!)
                self.uiState = .ApiError("Results could not be fetched")
            }
            else if (response.value!.results.isEmpty) { self.uiState = .NoResultsFound }
            else { self.uiState = .Fetched(response.value!) }
        }.store(in: &disposables)
    }
}

enum HomePageState {
    case Init
    case Loading
    case Fetched(Movies)
    case NoResultsFound
    case ApiError(String)
}
