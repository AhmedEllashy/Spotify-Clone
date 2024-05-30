//
//  SearchViewModel.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 07/05/2024.
//

import Foundation

protocol SearchViewModelDelegate : AnyObject{
    func updateUI()
    func errorOccured(with error : String)
}
protocol SearchViewModelProtocol{
    func search(with query : String)
}
enum SearchResultSections {
    case albums(model : [Album])
    case playlist(model : [Playlist])
    case tracks(model : [Track])
    case artists(model : [Artist])
    
    var title : String {
        switch self {
        case .albums :
            return "Albums"
        case .playlist :
            return "Playlists"
        case .tracks :
            return "Tracks"
        case .artists :
            return  "Artists"
        }
    }

}
class SearchViewModel : SearchViewModelProtocol {
    static let shared : SearchViewModel = SearchViewModel()
    weak var delegate : SearchViewModelDelegate?
    var searchResult = [SearchResultSections]()
    
    func search(with query: String) {
        searchResult = []
        APIManager.shared.search(query: query) { [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let model):
                    self?.searchResult.append(
                        SearchResultSections.albums(model: model.albums.items)
                    )
                    self?.searchResult.append(
                        SearchResultSections.playlist(model: model.playlists.items)
                    )
                    self?.searchResult.append(
                        SearchResultSections.tracks(model: model.tracks.items)
                    )
                    self?.searchResult.append(
                        SearchResultSections.artists(model: model.artists.items)
                    )
                    self?.delegate?.updateUI()
                case .failure(let error) : 
                    self?.delegate?.errorOccured(with: error.localizedDescription)
                }
            }
        }
    }
    
    
}
