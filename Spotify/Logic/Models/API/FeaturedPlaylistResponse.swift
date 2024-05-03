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


