//
//  Playlist.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 16/04/2024.
//

import Foundation

struct Playlist :Codable{
    let description : String
    let external_urls : [String : String]
    let id : String
    let images : [ImageResponse]
    let name : String
    let owner : Owner
}
struct Owner : Codable{
    let display_name : String
    let external_urls : [String : String]
    let id : String
}

