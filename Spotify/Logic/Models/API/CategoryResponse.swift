//
//  CategoryResponse.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 07/05/2024.
//

import Foundation

 
struct CategoryResponse : Codable{
    let categories : Categories
}
struct Categories : Codable {
    let items : [CategoryItemResponse]
}
struct CategoryItemResponse : Codable{
    let id : String
    let icons : [ImageResponse]
    let name : String
}
