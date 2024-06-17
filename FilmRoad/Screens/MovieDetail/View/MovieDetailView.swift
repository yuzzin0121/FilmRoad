//
//  MovieDetailView.swift
//  FilmRoad
//
//  Created by 조유진 on 6/7/24.
//

import SwiftUI

struct MovieDetailView: View {
    @ObservedObject var viewModel: MovieDetailViewModel
    
    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    posterImage(tv: viewModel.tv)
                    VStack(alignment: .leading, spacing: 6) {
                        tvText(name: viewModel.tv?.name)
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
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal, 10)
                    Spacer()
                }
            }
        }
        .task {
            viewModel.action(.viewOnAppear)
        }
    }
    
    func filterButtons() -> some View {
        HStack(spacing: 8) {
            ForEach(TVInfoItem.allCases, id: \.self) { tvInfoItem in
                Button {
                    print(tvInfoItem.rawValue)
                } label: {
                    Text("\(tvInfoItem.title)")
                        .foregroundStyle(.black)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 6)
                        .background(.white)
                        .clipShape(.rect(cornerRadius: 14))
                        .font(.system(size: 16))
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
            NavigationLink {
               
            } label: {
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
            }
        } placeholder: {
            NavigationLink {
              
            } label: {
                Rectangle()
                    .fill(.white.opacity(0.1))
                    .frame(height: 200)
            }
        }
    }
}

struct SeasonCellView: View {
    var body: some View {
        HStack {
            VStack {
                
            }
            Spacer()
            
        }
    }
}
