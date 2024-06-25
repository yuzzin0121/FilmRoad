//
//  Profile.swift
//  FilmRoad
//
//  Created by 조유진 on 6/25/24.
//

import Foundation
import RealmSwift

struct Profile {
    let id: ObjectId
    var nickname: String?
    var email: String?
    var profileImageData: Data?
    var isMale: Bool?
    var phoneNumber: String?
    
    init(id: ObjectId, nickname: String? = nil, email: String? = nil, profileImageData: Data? = nil, isMale: Bool? = nil, phoneNumber: String? = nil) {
        self.id = id
        self.nickname = nickname
        self.email = email
        self.profileImageData = profileImageData
        self.isMale = isMale
        self.phoneNumber = phoneNumber
    }
}
