//
//  HapticManager.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 03/06/2024.
//

import UIKit


class HapticManager {
    
    static let shared = HapticManager()
    
    public func setVibrate()
    {
        DispatchQueue.main.async {
            let generator = UISelectionFeedbackGenerator()
            generator.prepare()
            generator.selectionChanged()
        }
    }
    public func vibrate(for type : UINotificationFeedbackGenerator.FeedbackType){
        DispatchQueue.main.async {
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(type)
        }
    }
}
