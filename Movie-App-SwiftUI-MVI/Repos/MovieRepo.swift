//
//  MovieRepo.swift
//  Movie-App-SwiftUI-MVI
//
//  Created by David Aziz [Pharma] on 03/09/2022.
//

import RxSwift
import Alamofire
import Foundation

class MovieRepo {

    func createRequest<T: Codable>(url: String) -> Observable<T> {
        
        let observable = Observable<T>.create { observer -> Disposable in
            AF
                .request(url.replacingOccurrences(of: " ", with: "%20"))
                .validate()
                .responseJSON { response in
                    switch response.result {
                        
                    case .success:
                        guard let data = response.data else {
                            observer.onError(response.error ?? MyError.runtimeError("runtime error"))
                            return
                        }
                        do {
                            let projects = try JSONDecoder().decode(T.self, from: data)
                            observer.onNext(projects)
                        } catch { observer.onError(error) }
                        
                    case .failure(let error): observer.onError(error)
                    }
            }
            return Disposables.create()
        }.observe(on: MainScheduler.instance)
        return observable
    }
    
    
    func fetchMovies() -> Observable<Movies> {
        return createRequest(url: EndPoints.fetchPopularMoviesEndpoint)
    }
    
    func searchMovies(query: String) -> Observable<Movies> {
        return createRequest(url: EndPoints.searchMoviesEndpoint.replacingOccurrences(of: "{query}", with: query))
    }
}
