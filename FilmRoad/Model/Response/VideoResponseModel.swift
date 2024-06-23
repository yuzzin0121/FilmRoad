//
//  VideoResponseModel.swift
//  FilmRoad
//
//  Created by 조유진 on 6/24/24.
//

import Foundation

struct VideoResponseModel: Decodable {
    let id: Int
    let results: [Video]
}

struct Video: Decodable {
    let key: String
}
