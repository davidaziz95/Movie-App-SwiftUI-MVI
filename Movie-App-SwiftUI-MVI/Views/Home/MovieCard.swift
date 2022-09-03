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
        
        HStack(alignment: .center, spacing: 25) {
            KFImage(URL(string: "https://image.tmdb.org/t/p/w300/\(movie.poster_path ?? "")"))
                .resizable()
                .frame(width: 100, height: 150)
                .cornerRadius(20)
//            Spacer()
            VStack(alignment: .leading) {
                HStack {
                    Text(movie.title)
                        .frame(alignment: Alignment.topLeading)
                        .foregroundColor(.black)
                        .font(.subheadline)
                }
                Text(movie.overview)
                    .foregroundColor(.gray)
                    .frame(width: 250, alignment: .topLeading)
                    .lineLimit(3)
            }
//            .padding()
        }
    }
}

struct MovieCard_Previews: PreviewProvider {
    static var previews: some View {
        MovieCard(movie: Movie(id: 10, title: "Harry", overview: "Once upon a time there was a big person", poster_path: "/nEufeZlyAOLqO2brrs0yeF1lgXO.jpg"))
    }
}
