//
//  TabItem.swift
//  FilmRoad
//
//  Created by 조유진 on 6/7/24.
//

import Foundation

enum TabItem {
    case home
    case myList
    case profile
    
    var title: String {
        switch self {
        case .home: return "홈"
        case .myList: return "내 북마크"
        case .profile: return "프로필"
        }
    }
    
    var image: String {
        switch self {
        case .home: return ImageString.video
        case .myList: return ImageString.bookmark
        case .profile: return ImageString.userSquare
        }
    }
    
    var selectedImage: String {
        switch self {
        case .home: return ImageString.videoSeleted
        case .myList: return ImageString.bookmark
        case .profile: return ImageString.userSquareSelected
        }
    }
}
