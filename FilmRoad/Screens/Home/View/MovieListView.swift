//
//  MovieListView.swift
//  FilmRoad
//
//  Created by 조유진 on 6/7/24.
//

import SwiftUI

struct MovieListView: View {
    enum MovieSection: Int {
        case topRated
        case trend
        case popular
        
        var title: String {
            switch self {
            case .topRated: return "이번주 인기 콘텐츠"
            case .trend: return "지금 뜨는 콘텐츠"
            case .popular: return "취향저격 인기 콘텐츠"
            }
        }
    }
    @StateObject private var viewModel = MovieListViewModel()
    
    init() {
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = .black

        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
    }
    
    func sectionView(tvList: [TV]) -> some View {
        ScrollView(.horizontal) {
            LazyHStack(content: {
                ForEach(tvList, id: \.id) { tv in
                    TVCellView(tv: tv)
                }
            })
        }
        .padding(.bottom, 20)
        .onAppear(perform: {
            print("야호")
        })
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.black)
                    .ignoresSafeArea()
            
                ScrollView {
                    Spacer()
                        .frame(height: 30)
                    
                    LazyVStack(alignment: .leading) {
                        ForEach(Array(viewModel.output.tvTotalList.enumerated()), id: \.element) { index, tvList in
                            Text(MovieSection(rawValue: index)!.title).bold()
                            sectionView(tvList: tvList)
                        }
                    }
                    .padding(.leading)
                }
            }
            .navigationBar {
                Text("FilmRoad")
                    .font(.title).bold()
            } trailing: {
                NavigationLink {
                    SearchFilmView()
                } label: {
                    Image(ImageString.search)
                }

            }

        }
        .foregroundStyle(.white)
        .task {
            viewModel.action(.viewOnAppear)
        }
    }
}

#Preview {
    MovieListView()
}
