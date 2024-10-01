//
//  LibraryToggleView.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 30/05/2024.
//

import UIKit

protocol LibraryToggleViewDelegate : AnyObject {
    func didTapPlaylistButtonLibraryToggleViewDelegate()
    func didTapAlbumButtonLibraryToggleViewDelegate()
}
class LibraryToggleView: UIView {
    //MARK: - Properties
    enum State {
        case playlists
        case albums
    }
    weak var delegate : LibraryToggleViewDelegate?
     var state : State = .playlists
    //MARK: - UIViews
    private let playlistButton : UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Playlist", for: .normal)
        return button
    }()
    private let albumButton : UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Album", for: .normal)
        return button
    }()
    private var indicatorView : UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        view.layer.cornerRadius = 8
        return view
    }()
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(playlistButton)
        addSubview(albumButton)
        addSubview(indicatorView)
        playlistButton.addTarget(self, action: #selector(didTapPlaylistButton), for: .touchUpInside)
        albumButton.addTarget(self, action: #selector(didTapAlbumButton), for: .touchUpInside)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        playlistButton.frame = CGRect(x: 0, y: 0, width: width / 2, height: 50)
        albumButton.frame = CGRect(x: playlistButton.right, y: 0, width: width / 2, height: 50)
        indicatorLayout()
    }
    //MARK: - Functions
    func indicatorLayout(){
        if state == .playlists {
            indicatorView.frame = CGRect(x: 0, y: playlistButton.bottom  , width: width / 2, height: 3)
        }else{
            indicatorView.frame = CGRect(x: width / 2, y: playlistButton.bottom  , width: width / 2, height: 3)
        }
    }
    @objc private func didTapPlaylistButton(){
        state = .playlists
        UIView.animate(withDuration: 0.2) {
            self.indicatorLayout()
        }
        self.delegate?.didTapPlaylistButtonLibraryToggleViewDelegate()

    }
    @objc private func didTapAlbumButton(){
        state = .albums
        UIView.animate(withDuration: 0.2) {
            self.indicatorLayout()
        }
        self.delegate?.didTapAlbumButtonLibraryToggleViewDelegate()
    }

    func update(with state : State){
        self.state = state
        UIView.animate(withDuration: 0.2) {
            self.indicatorLayout()
        }
    }
    

}
