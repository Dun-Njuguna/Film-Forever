//
//  Movie.swift
//  Film Forever
//
//  Created by Duncan K on 20/02/2022.
//

import Foundation


struct TrendingMoviesResponse: Codable {
    let page: Int
    let results: [Movie]
}

struct Movie: Codable {
    let adult: Bool?
    let backdrop_path: String?
    let genre_ids: [Int?]?
    let id: Int
    let media_type: String?
    let original_language: String?
    let original_title: String?
    let overview: String?
    let popularity: Double?
    let poster_path: String?
    let release_date: String?
    let title: String?
    let video: Bool?
    let vote_average: Double?
    let vote_count: Int?
}
