//
//  ContentDetail.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 22.10.2024.
//

import Foundation

// MARK: - ContentDetail
struct ContentDetail: Codable {
    let id: Int?
    let title, name, overview, posterPath, releaseDate: String?
    let numberOfSeasons: Int?
    let firstAirDate, lastAirDate, status: String?
    let runtime: Int?
    let genres: [Genre]?
    let voteAverage: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, title, name, overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case numberOfSeasons = "number_of_seasons"
        case firstAirDate = "first_air_date"
        case lastAirDate = "last_air_date"
        case status, runtime, genres
        case voteAverage = "vote_average"
    }
    
    var genresString: String {
        guard let genres = genres, !genres.isEmpty else { return "N/A" }
        let names = genres.map({$0.name ?? ""})
        
        return names.joined(separator: ", ")
    }
    
    var runtimeString: String {
        guard let runtime = runtime, runtime != 0 else {
            return "N/A"
        }
        
        let hour = runtime / 60
        let minute = runtime % 60
        
        let hourString = hour == 0 ? "" : "\(hour)h "
        let minuteString = minute == 0 ? "" : "\(minute)m"
        
        return hourString + minuteString
    }
    
    var releaseDateString: String {
        guard let releaseDate = releaseDate, !releaseDate.isEmpty else { return "N/A" }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: releaseDate) {
            dateFormatter.dateFormat = "dd/MM/yyyy"
            return dateFormatter.string(from: date)
        }
        
        return "N/A"
    }

    var startEndDate: String {
        guard let firstAirDate = firstAirDate else { return "N/A" }
        
        let firstYear = String(firstAirDate.prefix(4))
        guard let lastAirDate = lastAirDate else { return firstYear }
        
        let lastYear = String(lastAirDate.prefix(4))
        
        return firstYear == lastYear ? firstYear : "\(firstYear) - \(lastYear)"
    }
    
    var season: String {
        guard let numberOfSeasons = numberOfSeasons else { return "N/A" }
        
        return "\(numberOfSeasons) Season"
    }
    
    var rating: String {
        guard voteAverage != 0 || voteAverage != nil else {
            return "N/A"
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 1
        numberFormatter.maximumFractionDigits = 1
        
        return numberFormatter.string(from: NSNumber(value: voteAverage ?? 0.0)) ?? "N/A"
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int?
    let name: String?
}
