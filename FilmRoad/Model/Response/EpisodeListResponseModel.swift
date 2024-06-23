//
//  EpisodeListResponseModel.swift
//  FilmRoad
//
//  Created by 조유진 on 6/23/24.
//

import Foundation

struct EpisodeListResponseModel: Decodable {
    let episodes: [Episode]
}

struct Episode: Decodable, Hashable {
    let episodeNumber: Int
    let id: Int
    let name: String
    let overview: String
    let runtime: Int
    let stillPath: String?
    let airDate: String?
    
    enum CodingKeys: String, CodingKey {
        case episodeNumber = "episode_number"
        case id
        case name
        case overview
        case runtime
        case stillPath = "still_path"
        case airDate = "air_date"
    }
    
    init(episodeNumber: Int, id: Int, name: String, overview: String, runtime: Int, stillPath: String?, airDate: String?) {
        self.episodeNumber = episodeNumber
        self.id = id
        self.name = name
        self.overview = overview
        self.runtime = runtime
        self.stillPath = stillPath
        self.airDate = airDate
    }
}
