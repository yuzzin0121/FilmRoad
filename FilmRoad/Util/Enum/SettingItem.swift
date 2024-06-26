//
//  SettingItem.swift
//  FilmRoad
//
//  Created by 조유진 on 6/26/24.
//

import Foundation

enum SettingItem: Int, CaseIterable {
    case notice
    case question
    case qAndA
    case reset
    
    var title: String {
        switch self {
        case .notice: "공지사항"
        case .question: "자주 묻는 질문"
        case .qAndA: "1:1 문의"
        case .reset: "북마크 리셋"
        }
    }
}
