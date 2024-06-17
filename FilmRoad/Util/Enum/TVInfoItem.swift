//
//  TVInfoItem.swift
//  FilmRoad
//
//  Created by 조유진 on 6/16/24.
//

import Foundation

enum TVInfoItem: Int, CaseIterable, Hashable {
    case season
    case castInfo
    case similarContents
    
    var title: String {
        switch self {
        case .season: "시즌"
        case .castInfo: "캐스트 정보"
        case .similarContents: "비슷한 콘텐츠"
        }
    }
}
