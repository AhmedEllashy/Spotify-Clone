//
//  LibraryViewController.swift
//  Spotify Clone
//
//  Created by Ahmad Ellashy on 23/03/2024.
//

import UIKit

class LibraryViewController: UIViewController {
    //MARK: - Properties
    private let playlistVC  = LibraryPlaylistViewController()
    private let albumVC = LibraryAlbumsViewController()
    private let toggleView = LibraryToggleView()
    //MARK: - UIComponents
    private var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.delaysContentTouches = true
        scrollView.canCancelContentTouches = false
        scrollView.isExclusiveTouch = true
        return scrollView
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Library"
        view.addSubview(toggleView)
        view.addSubview(scrollView)
        scrollView.contentSize = CGSize(width: view.width * 2, height: view.height)
        scrollView.delegate = self
        scrollView.clipsToBounds = true
        toggleView.delegate = self
        addChildren()
        addPlaylistButton()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top + 60,
            width: view.width,
            height: view.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom - 60
        )
        toggleView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: 55)

    }


    //MARK: - Functions
    private func addChildren(){
        addChild(playlistVC)
        scrollView.addSubview(playlistVC.view)
        playlistVC.view.frame = CGRect(x: 0, y: 0, width: scrollView.width, height: scrollView.height)
        playlistVC.didMove(toParent: self)

        addChild(albumVC)
        scrollView.addSubview(albumVC.view)
        albumVC.view.frame = CGRect(x: view.width, y: 0, width: scrollView.width, height: scrollView.height)
        albumVC.didMove(toParent: self)
        
    }
    private func addPlaylistButton(){
        switch toggleView.state {
        case .playlists :
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: .add, style: .done, target: self, action: #selector(didTapAdd))
        case .albums :
            navigationItem.rightBarButtonItem = nil
        }
    }
    @objc private func didTapAdd(){
        let alert = UIAlertController(title: "Add Playlist", message: "", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Enter Playlist Name...."
        }
        alert.addAction(UIAlertAction(title: "ADD", style: .default, handler: { action in
            guard let field = alert.textFields?.first, let text = field.text , !text.trimmingCharacters(in: .whitespaces).isEmpty else {
                return
            }
            LibraryViewModel.shared.createUserPlayist(with: text)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert,animated: true)
    }
  
}

extension LibraryViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x > 50 {
            toggleView.update(with: .albums)
            addPlaylistButton()
        }else{
            toggleView.update(with: .playlists)
            addPlaylistButton()
        }
    }
}

extension LibraryViewController : LibraryToggleViewDelegate {
    func didTapPlaylistButtonLibraryToggleViewDelegate() {
        scrollView.setContentOffset(.zero, animated: true)
        addPlaylistButton()

//        let vc = LibraryPlaylistViewController()
//        self.present(vc, animated: true)
    }
    
    func didTapAlbumButtonLibraryToggleViewDelegate() {
        scrollView.setContentOffset(CGPoint(x: scrollView.width, y: 0), animated: true)
        addPlaylistButton()
    }
    
}
