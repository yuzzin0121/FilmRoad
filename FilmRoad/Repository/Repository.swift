//
//  Repository.swift
//  FilmRoad
//
//  Created by 조유진 on 6/24/24.
//

import Foundation

protocol Repository: AnyObject {
    // 어떤 타입이 들어올 지 모르기 때문에 associatedtype 사용
    associatedtype ITEM
    
    func fetchItem() -> [ITEM]
    func deleteItem(id: Int)
    func createItem(data: ITEM)
    func updateItem(data: ITEM)
    func isExist(id: Int) -> Bool
}
