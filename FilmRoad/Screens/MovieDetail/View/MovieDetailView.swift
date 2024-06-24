//
//  MovieDetailView.swift
//  FilmRoad
//
//  Created by 조유진 on 6/7/24.
//

import SwiftUI

struct MovieDetailView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: MovieDetailViewModel
    
    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    NavigationLink {
                        TVVideoView(viewModel: TVVideoViewModel(seriesId: viewModel.output.tvInfoModel?.id))
                    } label: {
                        posterImage(tv: viewModel.output.tv)
                    }
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            tvText(name: viewModel.output.tv?.name)
                            Spacer()
                            bookmarkButton(isBookmarked: viewModel.output.tv?.isBookmarked)
                        }
                        descriptionText(viewModel.output.tvInfoModel?.overview)
                        HStack(spacing: 6) {
                            videoCountText(numberOfCount: viewModel.output.tvInfoModel?.numberOfSeasons, name: "시즌")
                            videoCountText(numberOfCount: viewModel.output.tvInfoModel?.numberOfEpisodes, name: "에피소드")
                            Spacer()
                        }
                        creatorText(creatorList: viewModel.output.tvInfoModel?.createdBy)
                        Spacer()
                            .frame(height: 12)
                        filterButtons()
                        Spacer()
                            .frame(height: 8)
                        
                        switch viewModel.output.currentInfoIndex {
                        case TVInfoItem.season.rawValue:
                            LazyVStack(spacing: 8) {
                                ForEach(viewModel.output.seasonList, id: \.self) { season in
                                    NavigationLink {
                                        EpisodeListView(viewModel: EpisodeListViewModel(seriesId: viewModel.output.tvInfoModel?.id, seasonNumber: season.seasonNumber))
                                    } label: {
                                        TVSeasonCellView(season: season)
                                    }
                                }
                            }
                        case TVInfoItem.castInfo.rawValue:
                            LazyVGrid(columns: Array(repeating: GridItem(), count: 4), content: {
                                ForEach(viewModel.output.castList, id: \.id) { cast in
                                    CastCellView(cast: cast)
                                }
                            })
                        case TVInfoItem.similarContents.rawValue:
                            LazyVGrid(columns: Array(repeating: GridItem(), count: 3), content: {
                                ForEach(viewModel.output.similarTVList, id: \.self) { similarTV in
                                    NavigationLink {
                                        MovieDetailView(viewModel: MovieDetailViewModel(tv: similarTV))
                                    } label: {
                                        TVThumbnailView(tv: similarTV)
                                    }
                                }
                            })
                        default:
                            EmptyView()
                        }
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal, 10)
                    Spacer()
                }
            }
            .navigationBarBackButtonHidden(true)    // default 버튼 지우기
            .navigationBar {
                Button{
                    dismiss()
                }label: {
                    Image(ImageString.arrowLeft)
                }
            } trailing: { }
            .foregroundStyle(.white)
        }
        .task {
            viewModel.action(.viewOnAppear)
        }
    }
    
    func bookmarkButton(isBookmarked: Bool?) -> some View {
        guard let isBookmarked else {
            return Image(.bookmark)
                    .resizable()
                    .frame(width: 18, height: 22)
                    .foregroundStyle(.darkGray)
                    .wrapToButton {}
        }
        return Image(.bookmark)
            .resizable()
            .frame(width: 18, height: 22)
            .foregroundStyle(isBookmarked ? .white : .darkGray)
            .wrapToButton {
                viewModel.action(.setBookmark)
            }
    }
    
    func filterButtons() -> some View {
        HStack(spacing: 8) {
            ForEach(TVInfoItem.allCases, id: \.self) { tvInfoItem in
                Button {
                    viewModel.action(.selectInfoIndex(index: tvInfoItem.rawValue))
                } label: {
                    Text("\(tvInfoItem.title)")
                        .foregroundStyle(tvInfoItem.rawValue == viewModel.output.currentInfoIndex ? .black : .white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 6)
                        .background(tvInfoItem.rawValue == viewModel.output.currentInfoIndex ? .white : .darkGray)
                        .clipShape(.rect(cornerRadius: 14))
                        .font(.system(size: 15))
                }
                
            }
        }
    }
    
    func creatorText(creatorList: [Creater]?) -> some View {
        if let creatorList {
            let names = creatorList.map { $0.name }.joined(separator: ", ")
            return Text("크리에이터: \(names)")
                    .font(.system(size: 12))
                    .foregroundStyle(.gray)
            
        } else {
            return Text("")
                .foregroundStyle(.gray)
        }
    }
    
    func videoCountText(numberOfCount: Int?, name: String) -> some View {
        if let numberOfCount {
            Text("\(name) \(numberOfCount)개")
                .font(.system(size: 12))
                .foregroundStyle(.gray)
        } else {
            Text("")
                .foregroundStyle(.gray)
        }
    }
    
    func tvText(name: String?) -> some View {
        HStack {
            Text(name ?? "")
                .font(.title3).bold()
            
            Spacer()
        }
    }
    
    func descriptionText(_ description: String?) -> some View {
        HStack {
            Text(description ?? "")
                .font(.system(size: 14))
                .lineSpacing(2)
                .foregroundStyle(.white)
            Spacer()
        }
    }
    
    func posterImage(tv: TV?) -> some View {
        AsyncImage(url: URL(string: APIKey.basePosterURL.rawValue + (tv?.posterPath ?? ""))) { image in
            image
                .resizable()
                .frame(height: 200)
                .overlay {
                    VStack(alignment: .center) {
                        Image(ImageString.playCircle)
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                }
        } placeholder: {
            Rectangle()
                .fill(.white.opacity(0.1))
                .frame(height: 200)
        }
    }
}

