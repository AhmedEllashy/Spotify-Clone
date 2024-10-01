//
//  Alerts.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 07/04/2024.
//

import UIKit


struct Utilities {
    static func errorALert(message : String,actionTitle : String? ,action : ()-> Void?,vc : UIViewController){
        let alert = UIAlertController(title: "Oops", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle ?? "OK", style: .cancel))
        vc.present(alert,animated: true)
    }
    static func successALert(message : String, actionTitle : String? ,action : ()-> Void?,vc : UIViewController){
        let alert = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle ?? "OK", style: .cancel))
        vc.present(alert,animated: true)
    }
}
