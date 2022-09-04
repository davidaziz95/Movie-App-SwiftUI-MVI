//
//  MovieDetails.swift
//  Movie-App-SwiftUI-MVI
//
//  Created by David Aziz [Pharma] on 03/09/2022.
//

import SwiftUI
import Kingfisher

struct MovieDetails: View {
    
    var movie: Movie
    var body: some View {
        
        ScrollView {
            HStack(alignment: .center, spacing: 25) {
                KFImage(URL(string: "https://image.tmdb.org/t/p/w300/\(movie.poster_path ?? "")"))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150, alignment: .center)
                    .clipShape(Circle())
                Text(movie.title)
                    .frame(alignment: Alignment.topLeading)
                    .foregroundColor(.black)
                    .font(.headline)
                Spacer()
            }.padding(.horizontal, 10).padding(.bottom, 20)
            
            HStack {
                Text("Overview")
                    .fontWeight(.bold)
                    .font(.system(size: 26))
                Spacer()
            }.padding(.horizontal, 10)
            
            SeeMoreModifier(movie.overview, lineLimit: 7, font: UIFont.systemFont(ofSize: 16, weight: .regular))
                .padding(.horizontal, 20)
        }
    }
}

struct MovieDetails_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetails(movie: Movie(id: 10, title: "ddssds", overview: "Many years after the war has been lost, and all the dragons slain, a lone knight travels the lands of Agonos seeking to raise an army against the demon lord Abaddon. When a healer\'s vision reveals that one dragon still lives, and together with an eager young squire, the knight sets off in search of the fabled creature. As the armies of Abaddon descend on the human kingdoms, the dragon is their last hope of fending off the horde, before it lays waste to the lands of men. But does the creature even exist? And if it does, will it fight for them once more? A rock climbing adventure between two friends turns into a terrifying nightmare. After Kelly captures the murder of her best friend on camera, she becomes the next target of a tight-knit group of friends who will stop at nothing to destroy the evidence and anyone in their way. Desperate for her safety, she begins a treacherous climb up a mountain cliff and her survival instincts are put to the test when she becomes trapped with the killers just 20 feet away.", poster_path: "/zkGFADykBtfPfTv7YJooxTH52ph.jpg"))
    }
}
