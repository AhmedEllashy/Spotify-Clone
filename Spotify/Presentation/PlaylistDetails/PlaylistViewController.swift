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
    }
    //MARK: - Functions
    private func setup (){
        title = playlist.name
        addShareNavBarButton()
        PlaylistDetailsViewModel.shared.getPlaylist(id: playlist.id)
        PlaylistDetailsViewModel.shared.delegate = self
        configCollectionView()
        
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
            return cell
        case 1 :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendtionsCollectionViewCell.cellIdentifier, for: indexPath) as! RecommendtionsCollectionViewCell
            cell.config(PlaylistDetailsViewModel.shared.playlistDetails?.tracks?.items[indexPath.row].track)
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
    
    
}

//MARK: - View Model Delegate Methods
extension PlaylistViewController : PlaylistDetailsViewDelegate {
    func updateUIViews() {
        self.playlistCollectionView.reloadData()
    }
    
    func errorOccured(error: String) {
        Utilities.errorALert(title: "Oops", message: error, actionTitle: nil, action: {}, vc: self)
    }
    
    
}
