//
//  EndPoint.swift
//  CodeManagement
//
//  Created by Min Thet Maung on 25/05/2022.
//

import Foundation

fileprivate let apiKey = "24b871157a26de857c768283adb14fd4"

enum EndPoint {
    
    static let baseUrl = "https://api.themoviedb.org/3"
    static let imageUrl = "https://image.tmdb.org/t/p/w500"
    
    case upcoming
    
    var stringValue: String {
        switch self {
        case .upcoming: return "\(EndPoint.baseUrl)/movie/upcoming?api_key=\(apiKey)&page=1"
        default: return ""
        }
    }
    
}
