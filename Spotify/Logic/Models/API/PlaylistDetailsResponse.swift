//
//  PlaylistDetailsResponse.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 27/04/2024.
//

import Foundation
struct PlaylistDetailsResponse :Codable{
    let description : String
    let external_urls : [String : String]
    let id : String
    let images : [ImageResponse]
    let name : String
    let owner : Owner
    let tracks : PlaylistTrackResponse?
}

struct PlaylistTrackResponse : Codable {
    let items : [ItemTrackResponse]
}
struct ItemTrackResponse : Codable{
    let track : Track
}
