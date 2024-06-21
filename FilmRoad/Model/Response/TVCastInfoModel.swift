//
//  TVCastInfoModel.swift
//  FilmRoad
//
//  Created by 조유진 on 6/21/24.
//

import Foundation

struct TVCastInfoModel: Decodable {
    let cast: [Cast]
    let id: Int
}

struct Cast: Decodable, Identifiable {
    let id = UUID()
    let knownForDepartment: String
    let name: String
    let profilPath: String?
    let roles: [Role]
    
    enum CodingKeys: String, CodingKey {
        case knownForDepartment = "known_for_department"
        case name
        case profilPath = "profile_path"
        case roles
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.knownForDepartment = try container.decode(String.self, forKey: .knownForDepartment)
        self.name = try container.decode(String.self, forKey: .name)
        self.profilPath = try container.decodeIfPresent(String.self, forKey: .profilPath)
        self.roles = try container.decode([Role].self, forKey: .roles)
    }
}

struct Role: Decodable {
    let character: String
}
