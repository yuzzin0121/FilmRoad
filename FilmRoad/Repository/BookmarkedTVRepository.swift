//
//  BookmarkedTVRepository.swift
//  FilmRoad
//
//  Created by 조유진 on 6/24/24.
//

import Foundation
import RealmSwift

final class BookmarkedTVRepository: Repository {
    typealias ITEM = BookmarkedTV
    
    private let realm = try! Realm()
    
    deinit {
        print("BookmarkedTVRepository Deinit")
    }
    
    func fetchItem() -> [ITEM] {
        let Items = Array(realm.objects(ITEM.self))
        return Items
    }
    
    func deleteItem(id: Int) {
        if let item = realm.object(ofType: ITEM.self, forPrimaryKey: id) {
            do {
                try realm.write  {
                    realm.delete(item)
                }
            } catch {
                print(error)
            }
        }
    }
    
    func createItem(data: ITEM) {
        do {
            try realm.write {
                realm.add(data)
                print("Data Create")
            }
        } catch {
            print(error)
        }
    }
    
    func isExist(id: Int) -> Bool {
        let bookmarkedTV = realm.object(ofType: ITEM.self, forPrimaryKey: id)
        if let bookmarkedTV {
            return true
        } else {
            return false
        }
    }
}
