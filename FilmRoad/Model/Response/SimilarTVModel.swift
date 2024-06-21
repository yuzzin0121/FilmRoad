//
//  SimilarTVModel.swift
//  FilmRoad
//
//  Created by 조유진 on 6/21/24.
//

import Foundation

struct SimilarTVModel: Decodable {
    let page: Int
    let results: [TV]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
