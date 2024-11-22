//
//  Video.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 22.11.2024.
//

import Foundation

struct Video: Codable {
    let results: [VideoResult]?
}

struct VideoResult: Codable {
    let key: String?
    let type: String?
}
