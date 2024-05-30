//
//  CategoryViewModel.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 07/05/2024.
//

import Foundation

protocol CategoryViewModelDelegate {
    func updateUI()
    func errorOccured(with error : String)
}
protocol CategoryViewModelProtocol{
    func getCategories()
    func getCategoryplaylist(id : String)
}

class CategoryViewModel : CategoryViewModelProtocol {
    static let shared : CategoryViewModel = CategoryViewModel()
    var delegate : CategoryViewModelDelegate?
    var categories : [CategoryItemResponse] = []
    var playlists : [Playlist] = []
    func getCategories() {
        APIManager.shared.getCategories { [weak self] result in
            DispatchQueue.main.async{
                switch result {
                case .success(let model) :
                    self?.categories = model
                    self?.delegate?.updateUI()
                case .failure(let error) :
                    self?.delegate?.errorOccured(with: error.localizedDescription)
                }
            }
        }
    }
    func getCategoryplaylist(id : String) {
        APIManager.shared.getCategoryPlaylist(id: id) { [weak self] result in
            DispatchQueue.main.async{
                switch result {
                case .success(let model) :
                    self?.playlists = model.playlists.items
                    self?.delegate?.updateUI()
                case .failure(let error) :
                    self?.delegate?.errorOccured(with: error.localizedDescription)
                }
        
            }
        }
    }
    
    
    
}
