//
//  PlaylistDetailsViewModel.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 27/04/2024.
//

import Foundation

protocol PlaylistDetailsViewDelegate{
    func updateUIViews()
    func errorOccured(error : String)
}
protocol PlaylistDetailsViewProtocol{
    func getPlaylist(id: String)
}
class PlaylistDetailsViewModel  : PlaylistDetailsViewProtocol{
    static let shared = PlaylistDetailsViewModel()
    var delegate : PlaylistDetailsViewDelegate?
    var playlistDetails : PlaylistDetailsResponse?
    
    func getPlaylist(id: String) {
        APIManager.shared.getPlayistDetailsAPI(id: id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self?.playlistDetails = model
                    self?.delegate?.updateUIViews()
                case .failure(let error) : self?.delegate?.errorOccured(error: error.localizedDescription)
                }
            }
        }
    }
}
