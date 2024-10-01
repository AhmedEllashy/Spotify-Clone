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
    let id : String
    let album : Album?
    let artists : [Artist]
    let availableMarkets : [String]
    let discNumber , durationMs : Int
    let explicit : Bool
    let name : String
    let previewUrl : String?
//    let images : [ImageResponse]?
    
    enum CodingKeys : String , CodingKey {
        case album , artists, id
        case availableMarkets = "available_markets"
        case discNumber  = "disc_number"
        case durationMs = "duration_ms"
        case previewUrl = "preview_url"
        case explicit ,name
        
        
    }
}

         
