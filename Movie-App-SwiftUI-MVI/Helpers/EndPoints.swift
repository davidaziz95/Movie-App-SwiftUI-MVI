//
//  EndPoints.swift
//  Movie-App-SwiftUI-MVI
//
//  Created by David Aziz [Pharma] on 05/09/2022.
//

import Foundation

struct EndPoints {
    static let baseImageURL = "https://image.tmdb.org/t/p/w300/"
    static let moviesBaseUrl = "https://api.themoviedb.org/3/"
    
    static let moviesApiKey = "5ec2b35ce120a5e3a91c05d25a75a3ba"
    
    static let searchMoviesEndpoint =  moviesBaseUrl + "search/movie?api_key=\(moviesApiKey)&language=en-US&query={query}"
    static let fetchPopularMoviesEndpoint = moviesBaseUrl + "movie/popular?api_key=\(moviesApiKey)&language=en-US&page=1"
}
