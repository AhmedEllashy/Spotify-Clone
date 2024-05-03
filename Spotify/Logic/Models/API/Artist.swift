//
//  Artist.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 15/04/2024.
//

import Foundation


struct Artist :Codable{
    let id : String
    let name : String
    let type : String
    let external_urls : [String : String]
}
