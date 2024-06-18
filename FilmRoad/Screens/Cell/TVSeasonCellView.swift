//
//  TVSeasonCellView.swift
//  FilmRoad
//
//  Created by 조유진 on 6/17/24.
//

import SwiftUI

struct TVSeasonCellView: View {
    var season: Season
    
    init(season: Season) {
        self.season = season
    }
    
    var body: some View {
        HStack {
            TVPosterImageView(posterURLString: season.posterPath)
            
            HStack {
                VStack {
                    seasonNameText(name: season.name)
                    airDateText(airDate: season.airDate)
                }
                episodeCountText(count: season.episodeCount)
            }
        }
    }
    
    private func seasonNameText(name: String) -> some View {
        Text(name)
            .font(.system(size: 14))
    }
    
    private func airDateText(airDate: String) -> some View {
        Text(airDate)
            .font(.system(size: 12))
            .foregroundStyle(.gray)
    }
    
    private func episodeCountText(count: Int) -> some View {
        Text("에피소드 \(count)개")
            .font(.system(size: 12))
    }
}
