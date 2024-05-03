//
//  ProfileViewModel.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 07/04/2024.
//

import Foundation

protocol ProfileViewModelProtocol {
    func getUserData()
}

protocol ProfileViewModelDelegate :AnyObject {
    func updateUI()
    func errorOccured(error : String)
}



class ProfileViewModel : ProfileViewModelProtocol{
    
    var userData : UserProfile?
    weak var delegate : ProfileViewModelDelegate?


    
    func getUserData() {
            APIManager.shared.getUserProfile { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        self?.userData = data
                        self?.delegate?.updateUI()
                    case .failure(let error):
                        self?.delegate?.errorOccured(error: error.localizedDescription)
                    }
                }
            }
        
   
    }
    
    
    
    
    
    
    
    
}
