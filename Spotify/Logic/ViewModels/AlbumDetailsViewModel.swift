//
//  AlbumDetailsViewModel.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 25/04/2024.
//

import Foundation

protocol AlbumDetailsViewDelegate{
    func errorOccured(for error : String)
    func updateUIViews()
}

protocol AlbumDetailsViewProtocol{
    func getAlbum(id: String)
}

class AlbumDetailsViewModel : AlbumDetailsViewProtocol{
    
    static let shared = AlbumDetailsViewModel()
    
    var delegate : AlbumDetailsViewDelegate?
    var album : AlbumDetails?
//    var tracks : [Track]?
    
    func getAlbum(id: String) {
        APIManager.shared.getAlbumDetails(id: id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let album) :
                    self?.album = album
                    self?.delegate?.updateUIViews()
                case .failure(let error) :
                    self?.delegate?.errorOccured(for: error.localizedDescription)
                }
            }
        }
    }
    
    
}
