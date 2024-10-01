//
//  FeaturedPlaylistResponse.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 16/04/2024.
//

import Foundation


struct FeaturedPlaylistResponse : Codable{
    let playlists : PlaylistsResponse
}
struct PlaylistsResponse : Codable{
    let items : [Playlist]
}
struct PlaylistsResponseCus : Codable{
    let items : [PlaylistCus]
}

struct PlaylistCus :Codable{
    let description : String
    let external_urls : [String : String]
    let id : String
    let images : [ImageResponse]?
    let name : String?
    let owner : Owner
}

