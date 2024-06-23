//
//  TMDBRouter.swift
//  FilmRoad
//
//  Created by 조유진 on 6/7/24.
//

import Foundation
import Alamofire

enum TMDBRouter {
    case topRated
    case trend(page: Int=1)
    case popular(page: Int=1)
    
    case tvInfo(id: Int)
    case similarTVRecommendation(id: Int)
    case dramaCaseInfo(id: Int)
    
    case tvSearch(query: String)
    case tvSeasonsDetails(seriesId: Int, seasonNumber: Int)
    
    case video(seriesId: Int)
}

extension TMDBRouter: TargetType {
    var baseURL: String {
        return APIKey.tmdbBaseURL.rawValue
    }
    
    static var videoBaseURL: String {
        return APIKey.videoBaseURL.rawValue
    }
    
    var path: String {
        switch self{
        case .topRated: return "tv/top_rated"
        case .trend: return "trending/tv/week"
        case .popular: return "tv/popular"
            
        case .tvInfo(let id): return "tv/\(id)"
        case .similarTVRecommendation(let id): return "tv/\(id)/recommendations"
        case .dramaCaseInfo(let id): return "tv/\(id)/aggregate_credits"
        case .tvSearch: return "search/tv"
        case .tvSeasonsDetails(let seriesId, let seasonNumber):
            return "tv/\(seriesId)/season/\(seasonNumber)"
        case .video(let seriesId):
            return "tv/\(seriesId)/videos"
        }
    }
    
    var header: [String : String] {
        return ["Authorization": APIKey.tmdbKey.rawValue]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: String? {
        return nil
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .topRated, .tvInfo, .tvSeasonsDetails, .video:
            return [
                URLQueryItem(name: "language", value: "ko-KR")
            ]
        case .trend(let page), .popular(let page):
            return [
                URLQueryItem(name: "language", value: "ko-KR"),
                URLQueryItem(name: "page", value: String(page))
            ]
            
        case .similarTVRecommendation, .dramaCaseInfo:
            return [
                URLQueryItem(name: "language", value: "ko-KR"),
                URLQueryItem(name: "page", value: String(1))
            ]
        case .tvSearch(query: let query):
            return [
                URLQueryItem(name: "language", value: "ko-KR"),
                URLQueryItem(name: "query", value: query)
            ]
        }
    }
    
    var body: Data? {
        switch self {
        default:
            return nil
        }
    }
}
