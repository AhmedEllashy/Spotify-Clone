//
//  LibraryPlaylistViewController.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 30/05/2024.
//

import UIKit

class LibraryPlaylistViewController: UIViewController {

    //MARK: - Properties
    public var selectionHandler : ((Playlist) -> Void)?
    private var viewModel = LibraryViewModel.shared
    private var observer : NSObjectProtocol?
    
    //MARK: - UIViews
    private var errorLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()
     var tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(PlaylistTableViewCell.self, forCellReuseIdentifier: PlaylistTableViewCell.identifier)
        return tableView
    }()
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(errorLabel)
        view.addSubview(tableView)
        viewModel.delegate = self
        errorLabel.isHidden = true
        configTableView()
        tableView.isUserInteractionEnabled = true
        LibraryViewModel.shared.getUserPlaylist()
        observer = NotificationCenter.default.addObserver(forName: .playlistSavedNotification, object: nil, queue: .main, using: { [weak self] _ in
            LibraryViewModel.shared.getUserPlaylist()
            self?.tableView.reloadData()
        })

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        errorLabel.frame = CGRect(x: 0, y: 0, width: 180, height: 80)
        errorLabel.center = view.center
        tableView.frame = view.bounds
    }
    
    private func configTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }


}
//MARK: - LibraryViewModelDelegate
extension LibraryPlaylistViewController : LibraryViewModelDelegate {
    func addTouUserLibrary() {
        self.presentedViewController?.dismiss(animated: true)
        let alert = UIAlertController(title: "Success", message: "Added Successfully", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        viewModel.getUserPlaylist()
    }
    
    func updateUI() {
        if viewModel.playlists.isEmpty {
            errorLabel.text = "There is no Playlists, Add One throw The top right corner button."
            errorLabel.isHidden = true
        }else{
            errorLabel.isHidden = true
        }
        self.tableView.reloadData()

    }
    
    func errorOccured(error: String) {
        errorLabel.text = error
        errorLabel.isHidden = true
    }
    
    
}
//MARK: - UITableViewDelegate
extension LibraryPlaylistViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.playlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let playlist = viewModel.playlists[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlaylistTableViewCell.identifier, for: indexPath)
                as? PlaylistTableViewCell else{
            return UITableViewCell()
        }
        cell.config(with: playlist.images?.first?.url ?? "", and: playlist.name)

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        HapticManager.shared.setVibrate()
        tableView.deselectRow(at: indexPath, animated: true)
        guard selectionHandler == nil else{
            selectionHandler?(viewModel.playlists[indexPath.row])
            return
        }
        let vc = PlaylistViewController(playlist: viewModel.playlists[indexPath.row])
        vc.isOwner = true
        self.navigationController?.pushViewController(vc, animated: true)
    }

    
    
}
