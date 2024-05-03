//
//  Album.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 15/04/2024.
//

import Foundation

struct Album : Codable{
    let album_type : String
    let available_markets : [String]
    let artists : [Artist]
    let id : String
    let images : [ImageResponse]
    let name : String
    let release_date : String
    let total_tracks : Int
    let tracks : [RecommendationsResponse]?
}

struct AlbumDetails : Codable{
    let album_type : String
    let available_markets : [String]
    let artists : [Artist]
    let id : String
    let images : [ImageResponse]
    let name : String
    let release_date : String
    let total_tracks : Int
    let tracks : TrackResponse
}
struct TrackResponse : Codable {
    let limit : Int
    let items : [Track]
}

