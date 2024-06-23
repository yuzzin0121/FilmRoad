//
//  EpisodeListView.swift
//  FilmRoad
//
//  Created by 조유진 on 6/23/24.
//

import SwiftUI

struct EpisodeListView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: EpisodeListViewModel
    
    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 12) {
                    ForEach(viewModel.output.episodeList, id: \.self) { episode in
                        TVEpisodeCellView(episode: episode)
                    }
                }
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
        .task {
            viewModel.action(.viewOnAppear)
        }
    }
}
