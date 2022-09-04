//
//  BarModifier.swift
//  Movie-App-SwiftUI-MVI
//
//  Created by David Aziz [Pharma] on 03/09/2022.
//

import SwiftUI

struct BarModifier: ViewModifier {
//    var backgroundColor: UIColor
    
    init() {
//        self.backgroundColor = UIColor.gray
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = .clear
//        coloredAppearance.titleTextAttributes = [.foregroundColor: self.backgroundColor]
//        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: self.backgroundColor]
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
//        UINavigationBar.appearance().tintColor = backgroundColor
    }
    
    func body(content: Content) -> some View {
        ZStack{
            content
//            VStack {
//                GeometryReader { geometry in
//                    Color(backgroundColor) // This is Color so we can reference frame
//                        .frame(height: geometry.safeAreaInsets.top)
//                        .edgesIgnoringSafeArea(.top)
//                    Spacer()
//                }
//            }
        }
    }
}

extension View {
    func barModifier() -> some View { self.modifier(BarModifier()) }
}
