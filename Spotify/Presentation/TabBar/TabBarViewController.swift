//
//  TabBarViewController.swift
//  Spotify Clone
//
//  Created by Ahmad Ellashy on 23/03/2024.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabs()
        print("Ahmad Ellashy!!")
    }

    private func setupTabs(){
        let homeView = self.createNav(with: "Home", and: UIImage(systemName: "house"), vc: HomeViewController())
        let searchView = self.createNav(with: "Search", and: UIImage(systemName: "clock"), vc: SearchViewController())
        let libraryView = self.createNav(with: "Home", and: UIImage(systemName: "cloud.snow"), vc: LibraryViewController())

        self.setViewControllers([homeView,searchView,libraryView], animated: true)
    }
    
    private func createNav(with title : String ,and image : UIImage?,vc : UIViewController) ->UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        return nav
    }


}
