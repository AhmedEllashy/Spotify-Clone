//
//  CategoryPlaylistViewController.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 07/05/2024.
//

import UIKit

class CategoryPlaylistViewController: UIViewController{
    //MARK: - Properties
    private let category : CategoryItemResponse
    private let viewModel : CategoryViewModel = CategoryViewModel.shared
    //MARK: - UIViews
    private var collectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { sectionProvider, _ in
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.5),
                    heightDimension: .fractionalHeight(1))
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(240)),
                repeatingSubitem: item,
                count: 2)
            return NSCollectionLayoutSection(group: group)
        }))
        return collectionView
    }()
  
    //MARK: - Built In Methods
    init(category: CategoryItemResponse) {
        self.category = category
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
    //MARK: - Function
    private func setup(){
        navigationController?.navigationBar.prefersLargeTitles = false
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        viewModel.delegate = self
        collectionView.register(FeaturedPlaylistsCollectionViewCell.self, forCellWithReuseIdentifier: FeaturedPlaylistsCollectionViewCell.cellIdentifier)
        viewModel.getCategoryplaylist(id: category.id)
    }

    


}
extension CategoryPlaylistViewController : UICollectionViewDelegate , UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.playlists.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let playlist = viewModel.playlists[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedPlaylistsCollectionViewCell.cellIdentifier, for: indexPath) as! FeaturedPlaylistsCollectionViewCell
        cell.config(playlist)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let vc = PlaylistViewController(playlist: viewModel.playlists[indexPath.row])
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension CategoryPlaylistViewController : CategoryViewModelDelegate {
    func updateUI() {
        self.collectionView.reloadData()
    }
    func errorOccured(with error: String) {
        Utilities.errorALert(title: "Ooops", message: error, actionTitle: nil, action: {}, vc: self)
    }
}
