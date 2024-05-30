//
//  PlayerViewModel.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 18/05/2024.
//

import UIKit
import AVFoundation


protocol PlayerViewModelDataSource : AnyObject {
    var songName : String? { get }
    var artistName : String? { get }
    var imageURL : String? { get }
}
protocol PlayerViewModelProtocol {
    func playTrack(track : Track,vc : UIViewController)
    func playTrack(tracks : [Track],vc : UIViewController)

}

class PlayerViewModel : PlayerViewModelProtocol {
    static let shared = PlayerViewModel()
    private var player : AVPlayer?
    private var playerQueue : AVQueuePlayer?
    private var track : Track?
    private var tracks = [Track]()
    private var currentTrack : Track? {
        if let trk = track, tracks.isEmpty {
            return trk
        }else if !tracks.isEmpty{
            return tracks.first!
        }
        return nil
    }
    
    func playTrack(track: Track, vc: UIViewController) {
        
        let playerVC = PlayerViewController()
        playerVC.dataSource = self
        playerVC.delegate = self
        self.track = track
        self.tracks = []
        guard let url = URL(string: track.previewUrl ?? "") else {
            return
        }
        player = AVPlayer(url: url)
        player?.volume = 0.1
        vc.present(UINavigationController(rootViewController: playerVC), animated: true) {
            self.player?.play()
            
        }
    }
    func playTrack(tracks: [Track], vc: UIViewController) {
   
        self.tracks = tracks
        self.track = nil
        let items : [AVPlayerItem] = tracks.compactMap { track in
            guard let url = URL(string: track.previewUrl ?? "") else{
                return nil
            }
             return AVPlayerItem(url: url)
        }
        self.playerQueue = AVQueuePlayer(items: items)
        let playerVC = PlayerViewController()
        playerVC.delegate = self
        playerVC.dataSource = self
        vc.present(UINavigationController(rootViewController: playerVC), animated: true) {
            self.playerQueue?.play()
            self.playerQueue?.volume = 0.1
            
        }
        
    }

}
extension PlayerViewModel : PlayerViewModelDataSource {
    var imageURL: String? {
        return currentTrack?.album?.images?.first?.url
    }
    
    var songName: String? {
        return currentTrack?.name
    }
    
    var artistName: String? {
        currentTrack?.artists.first?.name
    }
    
    
}
extension PlayerViewModel : PlayerViewDelegate{
    func UpdateUI(track: Track) {
        
    }
    
    func didTapPlayPausePlayViewDelegate() {
        if let player = player{
            if player.timeControlStatus == .playing {
                player.pause()
            }else if player.timeControlStatus == .paused{
                player.play()
            }
        }else if let player = playerQueue {
            if player.timeControlStatus == .playing {
                player.pause()
            }else if player.timeControlStatus == .paused{
                player.play()
            }
        }
    }
    
    func didTapForwardPlayViewDelegate() {
        if let player = player {
            player.pause()
        }else if let playerQueue = playerQueue {
            playerQueue.advanceToNextItem()
        }

    }
    
    func didTapBackwardPlayViewDelegate() {
        if let player = player {
            player.pause()
        }else if let playerQueue = playerQueue {
            print("bACKwARK Tapped")
        }   
    }
    func changeSliderValuePlayViewDelegate(sliderValue: Double) {
        if let player = player {
            player.volume = Float(sliderValue)
        }
    }
    
  
    
    
}
