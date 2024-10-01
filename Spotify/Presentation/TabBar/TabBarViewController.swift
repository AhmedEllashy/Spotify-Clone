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
    }

    private func setupTabs(){
        let homeView = self.createNav(with: "Home", and: UIImage(systemName: "house"), vc: HomeViewController())
        let searchView = self.createNav(with: "Search", and: UIImage(systemName: "magnifyingglass"), vc: SearchViewController())
        let libraryView = self.createNav(with: "Home", and: UIImage(systemName: "music.note.list"), vc: LibraryViewController())

        self.setViewControllers([homeView,searchView,libraryView], animated: true)
    }
    
    private func createNav(with title : String ,and image : UIImage?,vc : UIViewController) ->UINavigationController {
        tabBar.barStyle = .black
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
//        UITabBar.appearance().tintColor = UIColor(red: 0, green: 0, blue: 1, alpha: 1)
//        UITabBar.appearance().backgroundColor = UIColor.gray.withAlphaComponent(0.1)

//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)

        return nav
    }


}
