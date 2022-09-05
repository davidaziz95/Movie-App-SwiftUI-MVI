//
//  HomePageViewModel.swift
//  Movie-App-SwiftUI-MVI
//
//  Created by David Aziz [Pharma] on 03/09/2022.
//

import RxSwift
import Foundation

class HomePageViewModel: ObservableObject {
    
    let disposableBag = DisposeBag()
    let repository: MovieRepo = MovieRepo()
    @Published var uiState: HomePageState = .Init
    
    func loadMovies() async {
        self.uiState = .Loading
        do { try await Task.sleep(nanoseconds: UInt64(1000000000)) }
        catch {}
        
        repository
            .fetchMovies()
            .subscribe(
                onNext: { [weak self] response in
                    debugPrint(response)
                    if response.results.isEmpty { self?.uiState = .NoResultsFound }
                    else { self?.uiState = .Fetched(response) }
                },
                onError: { error in
                    debugPrint(error)
                    self.uiState = .ApiError("Results could not be fetched")
                }
            ).disposed(by: disposableBag)
    }
    
    func searchMovies(query: String) {
        self.uiState = .Loading
        repository
            .searchMovies(query: query)
            .subscribe(
                onNext: { [weak self] response in
                    debugPrint(response)
                    if response.results.isEmpty { self?.uiState = .NoResultsFound }
                    else { self?.uiState = .Fetched(response) }
                },
                onError: { error in
                    debugPrint(error)
                    self.uiState = .ApiError("Results could not be fetched")
                }
            ).disposed(by: disposableBag)
    }
}

enum HomePageState {
    case Init
    case Loading
    case Fetched(Movies)
    case NoResultsFound
    case ApiError(String)
}
