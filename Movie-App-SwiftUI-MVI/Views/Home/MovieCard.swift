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
    @State var isSelected = false
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 20) {
            
            ZStack(alignment: .topTrailing) {
                KFImage(URL(string: EndPoints.baseImageURL + (movie.poster_path ?? "")))
                    .resizable()
                    .frame(width: 100, height: 150)
                    .cornerRadius(20)
                
                if movie.poster_path != nil {
                    Rectangle()
                        .fill(LinearGradient(colors: [Color.black.opacity(0.8), Color.white], startPoint: .top, endPoint: .bottom))
                        .cornerRadius(20, corners: [.topLeft, .topRight])
                        .frame(width: 100 , height: 50).blendMode(.multiply)
                }
                Button {
                    isSelected.toggle()
                } label: {
                    Image(systemName: isSelected ? "heart.fill" : "heart")
                        .font(.system(size: 25))
                        .foregroundColor(Color.red)
                }.padding(8)
            }
            VStack(alignment: .leading) {
                Text(movie.title)
                    .frame(alignment: Alignment.topLeading)
                    .foregroundColor(.black)
                    .font(.headline)
                Text(movie.overview)
                    .foregroundColor(.gray)
                    .frame(width: 250, alignment: .topLeading)
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                
            }
        }
    }
}

struct MovieCard_Previews: PreviewProvider {
    static var previews: some View {
        MovieCard(movie: Movie(id: 10, title: "Harry", overview: "Once upon a time there was a big person", poster_path: "/nEufeZlyAOLqO2brrs0yeF1lgXO.jpg"))
    }
}
