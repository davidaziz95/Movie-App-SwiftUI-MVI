//
//  MovieRepo.swift
//  Movie-App-SwiftUI-MVI
//
//  Created by David Aziz [Pharma] on 03/09/2022.
//

import Combine
import Alamofire
import Foundation


protocol HomePageRepoProtocol {
    func fetchMovies() -> AnyPublisher<DataResponse<Movies, NetworkError>, Never>
    func searchMovies(query: String) -> AnyPublisher<DataResponse<Movies, NetworkError>, Never>
}


class HomePageRepo: HomePageRepoProtocol {
    
    static let shared: HomePageRepoProtocol = HomePageRepo()
    
    func createRequest<T: Codable>(stringURL: String) -> AnyPublisher<DataResponse<T, NetworkError>, Never> {
        
        let url = URL(string: stringURL.replacingOccurrences(of: " ", with: "%20"))!
        
        return AF.request(url)
            .validate()
            .publishDecodable(type: T.self)
            .map { response in response.mapError { error in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                    return NetworkError(initialError: error, backendError: backendError)
                }
            }.receive(on: DispatchQueue.main).eraseToAnyPublisher()
    }
    
    
    
    func fetchMovies() -> AnyPublisher<DataResponse<Movies, NetworkError>, Never> {
        return createRequest(stringURL: EndPoints.fetchPopularMoviesEndpoint)
    }
    
    func searchMovies(query: String) -> AnyPublisher<DataResponse<Movies, NetworkError>, Never> {
        return createRequest(stringURL: EndPoints.searchMoviesEndpoint.replacingOccurrences(of: "{query}", with: query))
    }
}
