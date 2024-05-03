//
//  SettingsModel.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 07/04/2024.
//

import Foundation


struct Section {
    let title : String
    let row : [Row]
}
struct Row {
    let title : String
    let handler : () -> Void
    
}
