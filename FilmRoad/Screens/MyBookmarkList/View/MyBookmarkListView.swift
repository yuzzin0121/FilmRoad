//
//  MyBookmarkListView.swift
//  FilmRoad
//
//  Created by 조유진 on 6/7/24.
//

import SwiftUI

struct MyBookmarkListView: View {
    @StateObject var viewModel: MyBookmarkListViewModel = MyBookmarkListViewModel(repository: BookmarkedTVRepository())
    
    init() {
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = .black

        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
    }
    
    var body: some View {
        NavigationWrapper {
            ZStack {
                Color(.black)
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                        .frame(height: 12)
                    ScrollView {
                        LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
                            ForEach(viewModel.output.bookmarkedTVList, id: \.id) { tv in
                                LazyNavigationLink {
                                    MovieDetailView(viewModel: MovieDetailViewModel(tv: tv, repository: BookmarkedTVRepository()))
                                } label: {
                                    bookmarkedTV(tv: tv)
                                }
                            }
                        }
                    }
                }
            }
            .navigationBar(title: {
            }, leading: {
                Text("Bookmark")
                    .font(.title).bold()
            }, trailing: {
            })
        }
        .foregroundStyle(.white)
        .task {
            viewModel.action(.viewOnAppear)
        }
    }
    
    private func bookmarkedTV(tv: TV) -> some View {
        TVThumbnailView(tv: tv)
            .overlay {
                VStack {
                    HStack {
                        Spacer()
                        Image(ImageString.bookmark)
                            .resizable()
                            .frame(width: 18, height: 22)
                            .wrapToButton {
                                viewModel.action(.bookmarkButtonTap(tvId: tv.id))
                            }
                            .padding(10)
                    }
                    Spacer()
                }
            }
    }
}
