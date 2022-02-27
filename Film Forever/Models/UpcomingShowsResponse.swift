//
//  UpcomingShowsResponse.swift
//  Film Forever
//
//  Created by Duncan K on 20/02/2022.
//

import Foundation

struct UpcomingShowsResponse: Codable {
    let page: Int
    let results: [Movie]
}
