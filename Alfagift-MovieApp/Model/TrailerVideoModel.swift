//
//  TrailerVideoModel.swift
//  Alfagift-MovieApp
//
//  Created by FauziArda on 11/01/23.
//

import Foundation

// MARK: - MovieTrailer
struct MovieTrailer : Decodable {
    let id: Int?
    let videos: [Video]?
    
    enum CodingKeys: String, CodingKey{
        case id
        case videos = "results"
    }
}

// MARK: - results
struct Video: Decodable {
    let iso639_1, iso3166_1, name, key: String?
    let site: String?
    let size: Int?
    let type: String?
    let official: Bool?
    let publishedAt, id: String?

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name, key, site, size, type, official
        case publishedAt = "published_at"
        case id
    }
}
