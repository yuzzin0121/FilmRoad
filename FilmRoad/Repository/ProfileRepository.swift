//
//  ProfileRepository.swift
//  FilmRoad
//
//  Created by 조유진 on 6/25/24.
//

import Foundation
import RealmSwift

final class ProfileRepository: Repository {
    typealias ITEM = ProfileRealmModel
    
    private let realm = try! Realm()
    
    init() {
//        print(realm.configuration.fileURL)
    }
    
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
    
    func updateItem(data: ITEM) {
        do {
            try realm.write  {
                realm.create(ITEM.self,
                             value: [
                                "id": data.id,
                                "nickname": data.nickname,
                                "email": data.email,
                                "profileImageData": data.profileImageData ?? nil,
                                "isMale": data.isMale,
                                "phoneNumber": data.phoneNumber
                             ], update: .modified)
            }
        } catch {
            print(error)
        }
    }
    
    func isExist(id: Int) -> Bool {
        let profileRealmModel = realm.object(ofType: ITEM.self, forPrimaryKey: id)
        if let profileRealmModel {
            return true
        } else {
            return false
        }
    }
}
