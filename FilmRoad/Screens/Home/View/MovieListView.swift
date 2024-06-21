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
    
    func randomTV(tv: TV?) -> some View {
        AsyncImage(url: URL(string: APIKey.basePosterURL.rawValue + (tv?.posterPath ?? ""))) { image in
            NavigationLink {
                MovieDetailView(viewModel: MovieDetailViewModel(tv: tv))
            } label: {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 370)
                    .clipShape(.rect(cornerRadius: 12))
                    .overlay {
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Image(ImageString.playButton)
                                    .shadow(radius: 10)
                            }
                        }
                        .padding(20)
                    }
            }
        } placeholder: {
            NavigationLink {
                MovieDetailView(viewModel: MovieDetailViewModel(tv: tv))
            } label: {
                Rectangle()
                    .fill(.white.opacity(0.1))
                    .frame(height: 370)
                    .clipShape(.rect(cornerRadius: 12))
            }
        }
        .padding(20)
        
    }
    
    func sectionView(tvList: [TV]) -> some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 0, content: {
                ForEach(tvList, id: \.id) { tv in
                    NavigationLink {
                        MovieDetailView(viewModel: MovieDetailViewModel(tv: tv))
                    } label: {
                        TVThumbnailView(tv: tv)
                            .frame(width: 140)
                    }
                }
            })
        }
        .padding(.bottom, 20)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.black)
                    .ignoresSafeArea()
            
                ScrollView {
                    randomTV(tv: viewModel.output.randomTV)
                    
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
