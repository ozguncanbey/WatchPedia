//
//  AllResults.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 19.10.2024.
//

enum AllResults {
    case contentResult(ContentResult)
    case trendingResult(KnownFor)
}

extension AllResults {
    var posterPath: String? {
        switch self {
        case .contentResult(let content):
            return content.posterPath
        case .trendingResult(let trending):
            return trending.posterPath
        }
    }
}
