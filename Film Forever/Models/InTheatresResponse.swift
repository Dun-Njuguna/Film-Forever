//
//  InTheatresResponse.swift
//  Film Forever
//
//  Created by Duncan K on 20/02/2022.
//

import Foundation

struct InTheatresResponse: Codable {
    let page: Int
    let results: [Movie]
}
