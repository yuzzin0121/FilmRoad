//
//  MyBookmarkListView.swift
//  FilmRoad
//
//  Created by 조유진 on 6/7/24.
//

import SwiftUI

struct MyBookmarkListView: View {
    
    init() {
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = .black

        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.black)
                    .ignoresSafeArea()
                LazyVStack {
                    
                }
            }
            .navigationBar {
                Text("Bookmark")
                    .font(.title).bold()
            } trailing: {}
        }
        .foregroundStyle(.white)
    }
}

#Preview {
    MyBookmarkListView()
}
