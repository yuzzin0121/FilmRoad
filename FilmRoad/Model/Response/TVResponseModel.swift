//
//  TVResponseModel.swift
//  FilmRoad
//
//  Created by 조유진 on 6/7/24.
//

import Foundation

struct TVResponseModel: Decodable {
    let results: [TV]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct TV: Decodable, Identifiable, Hashable {
    let id: Int
    let name: String
    let originalName: String
    let posterPath: String
    let backdropPath: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case originalName = "original_name"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.originalName = try container.decode(String.self, forKey: .originalName)
        self.posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath) ?? ""
        self.backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath) ?? ""
    }
    
    init(id: Int, name: String, originalName: String, posterPath: String, backdropPath: String) {
        self.id = id
        self.name = name
        self.originalName = originalName
        self.posterPath = posterPath
        self.backdropPath = backdropPath
    }
}
