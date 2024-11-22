//
//  Credits.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 22.11.2024.
//

import Foundation

struct Credits: Codable {
    let cast: [Cast]?
}

struct Cast: Codable {
    let id: Int?
    let name: String?
    let profilePath: String?
    let character: String?

    enum CodingKeys: String, CodingKey {
        case name, id
        case profilePath = "profile_path"
        case character
    }
}
