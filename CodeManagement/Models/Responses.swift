//
//  Responses.swift
//  CodeManagement
//
//  Created by Min Thet Maung on 25/05/2022.
//

import Foundation


struct UpcomingMovieResponse: Codable {
    let dates: Dates?
    let page, totalPages, totalResults, statusCode: Int?
    let statusMessage: String?
    let results: [MovieData]?

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case statusMessage = "status_message"
        case statusCode = "status_code"
        case totalResults = "total_results"
    }
}

// MARK: - Dates
struct Dates: Codable {
    let maximum, minimum: String?
}
