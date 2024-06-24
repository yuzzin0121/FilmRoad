//
//  TVRealmModel.swift
//  FilmRoad
//
//  Created by 조유진 on 6/24/24.
//

import Foundation
import RealmSwift

final class BookmarkedTV: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var originalName: String
    @Persisted var posterPath: String
    @Persisted var backdropPath: String
    
    convenience init(id: Int, name: String, originalName: String, posterPath: String, backdropPath: String) {
        self.init()
        self.id = id
        self.name = name
        self.originalName = originalName
        self.posterPath = posterPath
        self.backdropPath = backdropPath
    }
}
