//
//  FavoriteButton.swift
//  Movie-App-SwiftUI-MVI
//
//  Created by David Aziz [Pharma] on 06/09/2022.
//

import SwiftUI

struct FavoriteButton: View {
    @State private var isSelected = false
    
    let favoriteAction: () -> ()
    
    var body: some View {
        Button {
            isSelected.toggle()
            favoriteAction()
        } label: {
            Image(systemName: isSelected ? "heart.fill" : "heart")
                .font(.system(size: 20))
                .foregroundColor(Color.red)
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton {
            print("Favorite Button clicked")
        }
    }
}
