//
//  HomeViewController.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 22/04/2024.
//

import Foundation

protocol HomeViewModelDelegate {
    func errorOccured(error : String)
    func updateUI()
}

protocol HomeViewModelProtocol {
    func callFetchDataMethods()
    func getNewReleases(_ group : DispatchGroup)
    func getPlaylists(_ group : DispatchGroup)
    func getRecommendedTracks(_ group : DispatchGroup)
}

enum BrowseSectionType {
    case newReleases(model : [Album])
    case featuredPlaylists(model : [Playlist])
    case tracks(model : [Track])
    
    var title : String {
        switch self {
        case .newReleases :
            return "New Release Albums"
        case .featuredPlaylists :
            return "Featured Playlists"
        case .tracks :
            return "Tracks"
        }
    }
}

class HomeViewmModel : HomeViewModelProtocol{
    static let shared : HomeViewmModel = HomeViewmModel()
    var delegate : HomeViewModelDelegate?
    var albums : [Album] = []
    var playlists : [Playlist] = []
    var tracks : [Track] = []
    

    var sections = [BrowseSectionType]()

    func callFetchDataMethods(){
        let group = DispatchGroup()
        group.enter()
        group.enter()
        group.enter()

        getNewReleases(group)
        getPlaylists(group)
        getRecommendedTracks(group)
     


       
        group.notify(queue: .main) {
            self.sections.append(.newReleases(model: self.albums))
            self.sections.append(.featuredPlaylists(model: self.playlists ))
            self.sections.append(.tracks(model: self.tracks ))
            self.delegate?.updateUI()
        }
        
    }
    func getNewReleases(_ group : DispatchGroup) {
        APIManager.shared.getNewReleasesAPI { [weak self] result in
            DispatchQueue.main.async{
                defer{
                    group.leave()
                }
                switch result {
                case .success(let model) :
                    self?.albums = model.albums.items;
                case .failure(let error) :
                    self?.delegate?.errorOccured(error: error.localizedDescription)
                }
            }
        }
    }
    
    func getPlaylists(_ group : DispatchGroup) {
        APIManager.shared.getFeaturedPlaylistsAPI { [weak self] result in
            DispatchQueue.main.async{
                defer{
                    group.leave()
                }
                switch result {
                case .success(let model):
                    self?.playlists = model.playlists.items
                case .failure(let error):
                    self?.delegate?.errorOccured(error: error.localizedDescription)
                }
            }
        }
    }
    
    func getRecommendedTracks(_ group : DispatchGroup) {
        APIManager.shared.getRecommendationsAPI{ [weak self] result in
            DispatchQueue.main.async{
                defer{
                    group.leave()
                }
                switch result {
                case .success(let model):
                    self?.tracks = model.tracks
                    
                case .failure(let error):
                    self?.delegate?.errorOccured(error: error.localizedDescription)
                }
            }
        }
    }
    
    
}
