//
//  RecommendationsResponse.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 16/04/2024.
//

import Foundation


struct RecommendationsResponse : Codable{
    let tracks : [Track]
}

struct Track : Codable {
    let album : Album?
    let artists : [Artist]
    let availableMarkets : [String]
    let discNumber , durationMs : Int
    let explicit : Bool
    let name : String
    
    enum CodingKeys : String , CodingKey {
        case album , artists
        case availableMarkets = "available_markets"
        case discNumber  = "disc_number"
        case durationMs = "duration_ms"
        case explicit ,name
        
        
    }
}

         
