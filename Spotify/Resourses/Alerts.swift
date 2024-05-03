//
//  Alerts.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 07/04/2024.
//

import UIKit


struct Utilities {
    static func errorALert(title : String , message : String,actionTitle : String? ,action : ()-> Void?,vc : UIViewController){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle ?? "OK", style: .cancel))
        vc.present(alert,animated: true)
    }
}
