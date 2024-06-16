//
//  TVInfoResponseModel.swift
//  FilmRoad
//
//  Created by 조유진 on 6/15/24.
//

import Foundation

struct TVInfoResponseModel: Decodable {
    let backdropPath: String?
    let createdBy: [Creater]
    let id: Int
    let name: String
    let overview: String
    let numberOfEpisodes: Int
    let numberOfSeasons: Int
    let seasons: [Season]
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case createdBy = "created_by"
        case id
        case name
        case overview
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case seasons
    }
}

struct Creater: Decodable, Hashable {
    let name: String
}

struct Season: Decodable {
    let airDate: String
    let episodeCount: Int
    let id: Int
    let name: String
    let overview: String
    let posterPath: String?
    let seasonNumber: Int
    
    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeCount = "episode_count"
        case id
        case name
        case overview
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
    }
}
