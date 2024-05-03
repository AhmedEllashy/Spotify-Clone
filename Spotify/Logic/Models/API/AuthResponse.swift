//
//  Auth Response.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 04/04/2024.
//

import Foundation


struct AuthResponse : Codable{
    let access_token : String
    let expires_in : Double
    let refresh_token : String?
    let scope : String
    let token_type : String
}
