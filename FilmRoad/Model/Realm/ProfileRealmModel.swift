//
//  ProfileRealmModel.swift
//  FilmRoad
//
//  Created by 조유진 on 6/25/24.
//

import Foundation
import RealmSwift

final class ProfileRealmModel: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var nickname: String?
    @Persisted var email: String?
    @Persisted var profileImageData: Data?
    @Persisted var isMale: Bool?
    @Persisted var phoneNumber: String?
    
    convenience init(nickname: String? = nil, email: String? = nil, profileImageData: Data? = nil, isMale: Bool? = nil, phoneNumber: String? = nil) {
        self.init()
        self.nickname = nickname
        self.email = email
        self.profileImageData = profileImageData
        self.isMale = isMale
        self.phoneNumber = phoneNumber
    }
}
