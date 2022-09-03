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
                            observer.onError(response.error ?? MyError.runtimeError("random message"))
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
        return createRequest(url: "https://api.themoviedb.org/3/movie/popular?api_key=5ec2b35ce120a5e3a91c05d25a75a3ba&language=en-US&page=2")
    }
    
    func searchMovies(query: String) -> Observable<Movies> {
        return createRequest(url: "https://api.themoviedb.org/3/search/movie?api_key=5ec2b35ce120a5e3a91c05d25a75a3ba&language=en-US&query=\(query)")
    }
}
