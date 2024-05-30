//
//  AlbumViewController.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 25/04/2024.
//

import UIKit

class AlbumViewController: UIViewController {
    //MARK: - Properties
    private let album : Album
    private let viewModel = AlbumDetailsViewModel.shared
    private var collectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, _ in
            return AlbumViewController.createSectionLayout(index: sectionIndex)
        }))
        return collectionView
    }()
    //MARK: - UIViews
    private var albumImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        return imageView
    }()
    //MARK: - Built In Methods
    init(album: Album) {
        self.album = album
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
//MARK: - Functions
    private func setup(){
        self.title = album.name
        viewModel.getAlbum(id: album.id ?? "")
        viewModel.delegate = self
        configCollectionView()
    }
    private func configCollectionView(){
        view.addSubview(collectionView)
        collectionView.register(AlbumHeaderSectionCollectionViewCell.self, forCellWithReuseIdentifier: AlbumHeaderSectionCollectionViewCell.cellIdentifier)
        collectionView.register(RecommendtionsCollectionViewCell.self, forCellWithReuseIdentifier: RecommendtionsCollectionViewCell.cellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
    }
    private static func createSectionLayout(index : Int) -> NSCollectionLayoutSection {
        let section = index
        switch section {
        case 0 :
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
            )
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(0.4)
                ),
                repeatingSubitem: item,
                count: 1
            )
            let section = NSCollectionLayoutSection(group: group)
            return section
        case 1 :
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 5, bottom: 2, trailing: 5)
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(60)
                ),
                repeatingSubitem: item,
                count: 1
            )
            let section = NSCollectionLayoutSection(group: group)
            return section
        default :
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
            )
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(0.1)
                ),
                repeatingSubitem: item,
                count: 1
            )
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
    }
}
//MARK: - Collection View Delegate And DataSource Methods
extension AlbumViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = section
        switch section {
        case 0 :
            return 1
        case 1 :
            return viewModel.album?.tracks.items.count ?? 0
        default :
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = indexPath.section
        switch section {
        case 0 :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumHeaderSectionCollectionViewCell.cellIdentifier, for: indexPath) as! AlbumHeaderSectionCollectionViewCell
            cell.config(viewModel.album)
            return cell
        case 1 :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendtionsCollectionViewCell.cellIdentifier, for: indexPath) as! RecommendtionsCollectionViewCell
            cell.config(viewModel.album?.tracks.items[indexPath.row])
            return cell
        default :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            guard let track = viewModel.album?.tracks.items[indexPath.row] else{
                return
            }
            PlayerViewModel.shared.playTrack(track: track, vc: self)
            
        }
    }
    
}

//MARK: - View Model Delegate Methods
extension AlbumViewController : AlbumDetailsViewDelegate {
    func errorOccured(for error: String) {
        Utilities.errorALert(title: "Oops", message: error, actionTitle: nil, action: {}, vc: self)
        print(error)
    }
    
    func updateUIViews() {
        collectionView.reloadData()
    }
    
    
}
