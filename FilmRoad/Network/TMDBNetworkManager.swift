//
//  TMDBNetworkManager.swift
//  FilmRoad
//
//  Created by 조유진 on 6/7/24.
//

import Foundation

enum NetworkError: Error {
    case failedRequest
    case noData
    case invalidResponse
    case invalidData
}

final class TMDBNetworkManager {
    static let shared = TMDBNetworkManager()
    
    private init() { }
    
    func requestToTMDB<T: Decodable, U: TargetType>(model: T.Type, router: U) async throws -> T {
        let urlRequest = try router.asURLRequest()
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        
        guard let responseData = try? JSONDecoder().decode(T.self, from: data) else {
            throw NetworkError.invalidData
        }
        return responseData
    }
}

