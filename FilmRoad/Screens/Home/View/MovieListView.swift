//
//  MovieListView.swift
//  FilmRoad
//
//  Created by 조유진 on 6/7/24.
//

import SwiftUI

struct MovieListView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.black)
                    .ignoresSafeArea()
                
            }
            .navigationBar {
                Text("FilmRoad")
                    .font(.title2).bold()
            } trailing: {
                NavigationLink {
                    SearchFilmView()
                } label: {
                    Image(ImageString.search)
                }

            }

        }
        .foregroundStyle(.white)
    }
}

#Preview {
    MovieListView()
}
