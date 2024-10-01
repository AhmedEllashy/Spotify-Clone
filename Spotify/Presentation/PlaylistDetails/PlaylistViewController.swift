//
//  PlaylistDetailsViewController.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 25/04/2024.
//

import UIKit

class PlaylistViewController: UIViewController {
    //MARK: - Properties
    private let playlist : Playlist
    private let viewModel = PlaylistDetailsViewModel.shared
    private var observer : NSObjectProtocol?
    private var errorLabel : UILabel = {
        let label = UILabel()
        return label
    }()
     var isOwner : Bool = false
    //MARK: - UIViews
    private var playlistCollectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, _ in
            return PlaylistViewController.createSectionLayout(index: sectionIndex)
        }))
        return collectionView
    }()


    //MARK: - Built In Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    init(playlist: Playlist) {
        self.playlist = playlist
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playlistCollectionView.frame = view.bounds
        errorLabel.center = view.center
    }
    //MARK: - Functions
    private func setup (){
        title = playlist.name
        addShareNavBarButton()
        view.addSubview(errorLabel)
        errorLabel.isHidden = true
        PlaylistDetailsViewModel.shared.getPlaylist(id: playlist.id)
        PlaylistDetailsViewModel.shared.delegate = self
        configCollectionView()
        isOwner ? configIfIsOwner() : nil
        
        
    }
    private func configIfIsOwner(){
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(didTapLongPress(_:)))
        playlistCollectionView.addGestureRecognizer(gesture)

    }
    @objc func didTapLongPress(_ gesture : UILongPressGestureRecognizer){
        guard  gesture.state == .began else{
            return
        }
        let touchPoint = gesture.location(in: playlistCollectionView)
        guard let index = playlistCollectionView.indexPathForItem(at: touchPoint), index.section == 1 else{
            return
        }
        guard let track = viewModel.playlistDetails?.tracks?.items[index.row].track else{
            return
        }
        let actionSheet = UIAlertController(title: track.name, message: "Are you want add this to a playlist?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Delete", style: .default, handler: { action in
            LibraryViewModel.shared.deleteTrackFromPlaylist(playlist: self.playlist, track: track, vc: self)
            if self.viewModel.tracks.count >= 1 {
                self.viewModel.tracks.removeAll()
            }
//            self.playlistCollectionView.reloadData()
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(actionSheet,animated: true)
    }
    private func addShareNavBarButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(didTapShareButton)
        )
    }
    @objc private func didTapShareButton(){
        print(viewModel.playlistDetails?.external_urls as? [String : String] as Any)
        guard let  url = URL(string: viewModel.playlistDetails?.external_urls["spotify"] ?? "") else{
            return
        }
        let vc = UIActivityViewController(
            activityItems: ["Check This Playlist!",url],
            applicationActivities: []
        )
        present(vc,animated: true)
    }
    private func configCollectionView(){
        view.addSubview(playlistCollectionView)
        playlistCollectionView.register(HeaderSectionCollectionViewCell.self, forCellWithReuseIdentifier: HeaderSectionCollectionViewCell.cellIdentifier)
        playlistCollectionView.register(RecommendtionsCollectionViewCell.self, forCellWithReuseIdentifier: RecommendtionsCollectionViewCell.cellIdentifier)

        playlistCollectionView.delegate = self
        playlistCollectionView.dataSource = self
    }
    
    private static func createSectionLayout(index : Int) -> NSCollectionLayoutSection{
        switch index {
        case 0 : //Item
            let item = NSCollectionLayoutItem(
                layoutSize:
                    NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension:.fractionalHeight(1.0)
                    )
            )
            //Group
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.4)),
                repeatingSubitem: item,
                count: 1
            )
            //Section
            let section = NSCollectionLayoutSection(group: group)
            return section
            
        case 1 :
            //Item
            let item = NSCollectionLayoutItem(
                layoutSize:
                    NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension:.fractionalHeight(1.0)
                    )
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
            //Group
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.1)),
                repeatingSubitem: item,
                count: 1
            )
            //Section
            let section = NSCollectionLayoutSection(group: group)
//            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 20, trailing: 20)
            return section
        default :
            //Item
            let item = NSCollectionLayoutItem(
                layoutSize:
                    NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension:.fractionalHeight(1.0)
                    )
            )
            //Group
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3)),
                repeatingSubitem: item,
                count: 1
            )
            //Section
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
        
    }
    

}
//MARK: - Collection View Delegate and DataSource Methods
extension PlaylistViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = section
        switch section {
        case 0 :
            return 1
        case 1 :
            return viewModel.playlistDetails?.tracks?.items.count ?? 1
        default :
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = indexPath.section
        switch section {
        case 0 :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderSectionCollectionViewCell.cellIdentifier, for: indexPath) as! HeaderSectionCollectionViewCell
            if let details = PlaylistDetailsViewModel.shared.playlistDetails{
                cell.config(details)
            }
            cell.delegate = self
            return cell
        case 1 :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendtionsCollectionViewCell.cellIdentifier, for: indexPath) as! RecommendtionsCollectionViewCell
            print(viewModel.tracks.count)
            if viewModel.tracks.count >= 1 {
                cell.config(viewModel.tracks[indexPath.row].track)
            }
            return cell
        default :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderSectionCollectionViewCell.cellIdentifier, for: indexPath) as! HeaderSectionCollectionViewCell
//            if let details = PlaylistDetailsViewModel.shared.playlistDetails{
//                cell.config(details)
//            }
            cell.backgroundColor = .green

            return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            guard let track = viewModel.playlistDetails?.tracks?.items[indexPath.row].track else{
                return
            }
            PlayerViewModel.shared.playTrack(track: track, vc: self)

        }
    }
    
    
}

//MARK: - View Model Delegate Methods
extension PlaylistViewController : PlaylistDetailsViewDelegate {
    func updateUIViews() {
        playlistCollectionView.isHidden = false
        errorLabel.isHidden = true
        self.playlistCollectionView.reloadData()
    }
    
    func errorOccured(error: String) {
        playlistCollectionView.isHidden = true
        errorLabel.isHidden = false
        Utilities.errorALert(message: error, actionTitle: nil, action: {}, vc: self)
    }
    
    
}

extension PlaylistViewController : HeaderSectionCollectionViewCellDelegate{
    func didTapPlayAllCollectionViewCellDelegate() {
        guard let tracks = viewModel.playlistDetails?.tracks?.items.compactMap({$0.track}) else {
            Utilities.errorALert(message: "No Tracks To Play", actionTitle: nil, action: {}, vc: self)
            return
        }
        PlayerViewModel.shared.playTrack(tracks: tracks, vc: self)
    }
    
    
}
