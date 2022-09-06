//
//  MovieCard.swift
//  Movie-App-SwiftUI-MVI
//
//  Created by David Aziz [Pharma] on 03/09/2022.
//

import SwiftUI
import Kingfisher

struct MovieCard: View {
    
    let movie: Movie
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 10) {
            
            ZStack(alignment: .topTrailing) {
                KFImage(URL(string: EndPoints.baseImageURL + (movie.poster_path ?? "")))
                    .resizable()
                    .frame(width: 80, height: 120)
                    .cornerRadius(20)
                
                if movie.poster_path != nil {
                    Rectangle()
                        .fill(LinearGradient(colors: [Color.black.opacity(0.8), Color.white], startPoint: .top, endPoint: .bottom))
                        .cornerRadius(20, corners: [.topLeft, .topRight])
                        .frame(width: 80 , height: 50).blendMode(.multiply)
                }
                FavoriteButton { print(movie.title) }
            }
            VStack(alignment: .leading, spacing: 5) {
                Text(movie.title)
                    .frame(maxWidth: .infinity, alignment: Alignment.topLeading)
                    .foregroundColor(.black)
                    .font(.headline)
                Text(movie.overview)
                    .foregroundColor(.gray)
                    .frame(alignment: .topLeading)
                    .font(.caption2)
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                
            }
        }
    }
}

struct MovieCard_Previews: PreviewProvider {
    static var previews: some View {
        MovieCard(movie: Movie(id: 10, title: "Harry potter and the goblet of fire", overview: "Once upon a time there was a big person", poster_path: "/nEufeZlyAOLqO2brrs0yeF1lgXO.jpg"))
    }
}
