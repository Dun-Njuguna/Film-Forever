//
//  YoutubeSearchResponse.swift
//  Film Forever
//
//  Created by Duncan K on 27/02/2022.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let etag: String?
    let items: [Item?]?
    let kind: String?
    let nextPageToken: String?
    let pageInfo: PageInfo?
    let regionCode: String?
    let error: SearchError?
}

struct SearchError: Codable {
    let code: Int
    let message: String
    let status: String
    let errors: [ErrorObject]
}

struct ErrorObject: Codable {
    let domain: String
    let message: String
    let reason: String
}

struct PageInfo: Codable {
    let resultsPerPage: Int
    let totalResults: Int
}

struct Item: Codable {
    let etag: String
    let kind: String
    let id: VideoElement
}

struct VideoElement: Codable {
    let kind: String
    let videoId: String
}
