//
//  NewReleasesResponse.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 15/04/2024.
//

import Foundation

struct NewReleasesResponse : Codable {
    let albums : AlbumsResponse
}
struct AlbumsResponse : Codable{
    let items : [Album]
}
