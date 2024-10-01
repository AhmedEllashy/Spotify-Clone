//
//  LibraryViewModel.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 31/05/2024.
//

import Foundation
import UIKit

protocol LibraryViewModelDelegate: AnyObject{
    func updateUI()
    func errorOccured(error : String)
    func addTouUserLibrary()
}
protocol LibraryAlbumViewModelDelegate: AnyObject{
    func updateUI()
    func errorOccured(error : String)
    func addTouUserLibrary()
}

protocol LibraryViewModelProtocol {
    func getUserPlaylist()
    func createUserPlayist(with name : String)
    func addTrackToPlaylist(playlist : Playlist, track : Track, vc : UIViewController)
    func deleteTrackFromPlaylist(playlist : Playlist, track : Track, vc : UIViewController)
    func createUserAlbum(with album: Album,vc : UIViewController)
    func getUserAlbums()

}

class LibraryViewModel : LibraryViewModelProtocol{
    
    static let shared  = LibraryViewModel()
    weak var delegate : LibraryViewModelDelegate?
    weak var albumDelegate : LibraryAlbumViewModelDelegate?
    var playlists = [Playlist]()
    var albums = [Album]()
    func getUserPlaylist() {
        APIManager.shared.getUserPlaylists { [weak self] result in
            DispatchQueue.main.async{
                switch result{
                case .failure(let error): self?.delegate?.errorOccured(error: error.localizedDescription)
                case .success(let model) :
                    self?.playlists = model.items
                    self?.delegate?.updateUI()
                }
            }
        }
    }
    
    func createUserPlayist(with name : String) {
        APIManager.shared.createPlaylist(name: name) { [weak self] result in
            switch result {
            case .success(_) :
                NotificationCenter.default.post(name: .playlistSavedNotification, object: nil)
                self?.delegate?.addTouUserLibrary()
            case .failure(let error) :
                self?.delegate?.errorOccured(error: error.localizedDescription)
            }
        }
    }
    func addTrackToPlaylist(playlist: Playlist, track: Track, vc : UIViewController) {
    
        APIManager.shared.addTrackToPlaylist(playlist: playlist, track: track) { result in
            
            DispatchQueue.main.async{
                switch result {
                case .success(_) :
                    vc.presentedViewController?.dismiss(animated: true)
                    Utilities.successALert(message: "", actionTitle: nil, action: {}, vc: vc)
                case .failure(let error) :
                    vc.presentedViewController?.dismiss(animated: true)
                    Utilities.successALert(message: error.localizedDescription, actionTitle: nil, action: {}, vc: vc)
                }
            }
        }
    }
    func deleteTrackFromPlaylist(playlist: Playlist, track: Track, vc: UIViewController) {
        APIManager.shared.deleteTrackFromPlaylist(playlist: playlist, track: track) { result in
            DispatchQueue.main.async{
                switch result {
                case .success(_) :
                    vc.presentedViewController?.dismiss(animated: true)
                    Utilities.successALert(message: "", actionTitle: nil, action: {}, vc: vc)
                case .failure(let error) :
                    vc.presentedViewController?.dismiss(animated: true)
                    Utilities.successALert(message: error.localizedDescription, actionTitle: nil, action: {}, vc: vc)
                }
            }
        }
    }
    func createUserAlbum(with album: Album, vc : UIViewController) {
        APIManager.shared.createUserAlbum(album: album) {[weak self] result in
            switch result {
            case .success(_) :
                HapticManager.shared.vibrate(for: .success)
                NotificationCenter.default.post(name: .albumSavedNotification, object: nil)
                self?.albumDelegate?.addTouUserLibrary()
            case .failure(let error) :
                HapticManager.shared.vibrate(for: .success)
                self?.albumDelegate?.errorOccured(error: error.localizedDescription)
            }
        }
    }
    func getUserAlbums() {
        APIManager.shared.getUserAlbums { [weak self] result in
            DispatchQueue.main.async{
                switch result {
                case .success(let model) :
                    self?.albums = model.items.compactMap({$0.album})
                    self?.albumDelegate?.updateUI()
                case .failure(let error) :
                    self?.albumDelegate?.errorOccured(error: error.localizedDescription)
                }
            }
            
        }
    }
    
    
}
