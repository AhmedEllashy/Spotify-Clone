//
//  SearchResponse.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 08/05/2024.
//

import Foundation

struct SearchResponse : Codable{
    let albums : AlbumsResponse
    let playlists : PlaylistsResponse
    let tracks : TrackResponse
    let artists : ArtistResponse
}
struct SearchResponseTest : Codable{
    let albums : AlbumSearchResponse
//    let playlists : [PlaylistsResponse]
//    let tracks : [TrackResponse]
//    let artists : [ArtistResponse]
}
struct ArtistResponse : Codable{
    let items : [Artist]
}
struct AlbumSearchResponse : Codable{
    let items : [Album]
}
