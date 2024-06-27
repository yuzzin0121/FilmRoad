//
//  SearchFilmView.swift
//  FilmRoad
//
//  Created by 조유진 on 6/7/24.
//

import SwiftUI

struct SearchFilmView: View {
    @Environment(\.dismiss) var dismiss
    @State private var query: String = ""
    @StateObject var viewModel = SearchViewModel()
    
    init() {
        print("SearchFilmView Init")
    }
    
    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            VStack {
                Spacer()
                    .frame(height: 12)
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
                        ForEach(viewModel.output.searchedTVList, id: \.id) { tv in
                            LazyNavigationLink {
                                MovieDetailView(viewModel: MovieDetailViewModel(tv: tv, repository: BookmarkedTVRepository()))
                            } label: {
                                TVThumbnailView(tv: tv)
                            }
                        }
                    }
                }
            }
            .searchable(text: $viewModel.query)
        }
        .navigationBarBackButtonHidden(true)    // default 버튼 지우기
        .navigationBar(title: {
        }, leading: {
            Button{
                dismiss()
            }label: {
                Image(ImageString.arrowLeft)
            }
        }, trailing: {
        })
        .foregroundStyle(.white)
    }
}

#Preview {
    SearchFilmView()
}
