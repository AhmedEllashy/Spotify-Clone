//
//  Album.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 15/04/2024.
//

import Foundation

struct Album : Codable{
    let album_type : String?
    let available_markets : [String]?
    let artists : [Artist]?
    let id : String?
    let images : [ImageResponse]?
    let name : String?
    let release_date : String?
    let total_tracks : Int?
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

struct UserAlbumResponse : Codable {
    let items : [UserAlbum]
}
struct UserAlbum : Codable {
    let added_at : String
    let album : Album
}
