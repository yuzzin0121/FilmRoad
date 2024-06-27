//
//  TVEpisodeCellView.swift
//  FilmRoad
//
//  Created by 조유진 on 6/23/24.
//

import SwiftUI

struct TVEpisodeCellView: View {
    var episode: Episode
    
    init(episode: Episode) {
        self.episode = episode
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                TVPosterImageView(posterURLString: episode.stillPath)
                
                VStack {
                    Spacer()
                        .frame(height: 6)
                    VStack(alignment: .leading) {
                        episodeNameText(name: episode.name)
                        runtimeText(runtime: episode.runtime)
                    }
                    Spacer()
                }
            }
            overviewText(overview: episode.overview)
        }
    }
    
    private func episodeNameText(name: String) -> some View {
        Text(name)
            .font(.system(size: 14)).bold()
    }
    
    private func airDateText(airDate: String?) -> some View {
        Text(airDate ?? "")
            .font(.system(size: 12))
            .foregroundStyle(.gray)
    }
    
    private func runtimeText(runtime: Int) -> some View {
        Text("\(runtime)분")
            .font(.system(size: 12))
    }
    
    private func overviewText(overview: String) -> some View {
        Text(overview)
            .font(.system(size: 13))
            .foregroundStyle(.gray)
    }
}

#Preview {
    TVEpisodeCellView(episode: Episode(episodeNumber: 1, id: 4028510, name: "에피소드 1", overview: "안뇽안뇽", runtime: 32, stillPath: "/nYqYIMaeYbop2zpbnqHAe45Aahm.jpg", airDate: ""))
}
