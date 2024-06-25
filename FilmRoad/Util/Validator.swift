//
//  Validator.swift
//  FilmRoad
//
//  Created by 조유진 on 6/25/24.
//

import Foundation

struct Validator {
    func isValidNickname(nickname: String) async -> Bool {
        return nickname.count >= 2 && nickname.count <= 8
    }
    func isValidEmail(email: String) async -> Bool {
        return email.contains("@") && email.count >= 6
    }
    
    func isValidPhoneNumber(phoneNumber: String) async -> Bool {
        return phoneNumber.count >= 10 && phoneNumber.count <= 11
    }
}
