//
//  HomeViewController.swift
//  Spotify Clone
//
//  Created by Ahmad Ellashy on 23/03/2024.
//

import UIKit



class HomeViewController: UIViewController ,HomeViewModelDelegate {

    //MARK: - UIElements
    private var mainCollectionView : UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(
        sectionProvider: { sectionIndex, _ -> NSCollectionLayoutSection? in
        return HomeViewController.createSectionLayout(index:sectionIndex)
    }))
   private var errorLabel : UILabel = {
        let label = UILabel()
        return label
    }()

    //MARK: - Built In Methods
    override func viewDidLoad() {
        super.viewDidLoad()    
        setup()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainCollectionView.frame = view.bounds
        errorLabel.center = view.center
    }
    //MARK: - Function
    private func setup(){
        configureCollectionView()
        view.addSubview(errorLabel)
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Browse"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image:UIImage(systemName: "gear"),
            style: .done,
            target: self,
            action: #selector(didTapSettings)
        )
        HomeViewmModel.shared.delegate = self
        fetchData()
        configLongGesture()
    }
    private func configLongGesture(){
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(didTapLongGesture(_:)))
        mainCollectionView.addGestureRecognizer(gesture)
        
    }
    @objc private func didTapLongGesture (_ gesture : UILongPressGestureRecognizer){
        print("sTATT")
        guard gesture.state == .began else{
            return
        }
        let touchPoint = gesture.location(in: mainCollectionView)
        guard let index = mainCollectionView.indexPathForItem(at: touchPoint), index.section == 2 else{
            return
        }
        let track = HomeViewmModel.shared.tracks[index.row]
        let actionSheet = UIAlertController(title: track.name, message: "Are you want add this to a playlist?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Add", style: .default, handler: { action in
            let vc = LibraryPlaylistViewController()
            vc.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.didTapCancel))
            vc.selectionHandler = { playlist in
                LibraryViewModel.shared.addTrackToPlaylist(playlist: playlist, track: track, vc: self)
            }
            self.present(UINavigationController(rootViewController: vc),animated: true)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(actionSheet,animated: true)
        
    }
    @objc private func didTapCancel(){
        self.dismiss(animated: true)
    }
    private func configureCollectionView(){
        view.addSubview(mainCollectionView)
        mainCollectionView.register(NewReleasesCollectionViewCell.self, forCellWithReuseIdentifier: NewReleasesCollectionViewCell.cellIdentifier)
        mainCollectionView.register(FeaturedPlaylistsCollectionViewCell.self, forCellWithReuseIdentifier: FeaturedPlaylistsCollectionViewCell.cellIdentifier)
        mainCollectionView.register(RecommendtionsCollectionViewCell.self, forCellWithReuseIdentifier: RecommendtionsCollectionViewCell.cellIdentifier)
        mainCollectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        
    }
    @objc func didTapSettings(){
        let vc = SettingsViewController()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc,animated: true)
    }

    private func fetchData(){
        HomeViewmModel.shared.callFetchDataMethods()
    }


}

//MARK: - UICollectionViewDataSourceAndDelegateMethods
extension HomeViewController : UICollectionViewDataSource , UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let type = HomeViewmModel.shared.sections[section]
        switch type {
        case .newReleases(let model) :
            return model.count
        case .featuredPlaylists(let model) :
            return model.count
        case .tracks(let model) :
            return model.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let type =  HomeViewmModel.shared.sections [indexPath.section]
        switch type {
        case .newReleases(let model) :
            let vc = AlbumViewController(album: model[indexPath.row])
            vc.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(vc, animated: true)
        case .featuredPlaylists(let model) :
            let vc = PlaylistViewController(playlist: model[indexPath.row])
            vc.modalPresentationStyle = .fullScreen
            navigationController?.navigationBar.prefersLargeTitles = false
            navigationController?.pushViewController(vc, animated: true)
        case .tracks(let model) :
            let track = model[indexPath.row]
            PlayerViewModel.shared.playTrack(track: track, vc: self)
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return HomeViewmModel.shared.sections.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let type = HomeViewmModel.shared.sections[indexPath.section]
        switch type {
        case .newReleases(let model) :
            let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: NewReleasesCollectionViewCell.cellIdentifier, for: indexPath) as! NewReleasesCollectionViewCell
            cell.config(model[indexPath.row])
            return cell
            ///
        case .featuredPlaylists(let model) :
            let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: FeaturedPlaylistsCollectionViewCell.cellIdentifier, for: indexPath) as! FeaturedPlaylistsCollectionViewCell
            cell.config(model[indexPath.row])
            return cell
            ///
        case .tracks(let model) :
            let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: RecommendtionsCollectionViewCell.cellIdentifier, for: indexPath) as! RecommendtionsCollectionViewCell
            cell.config(model[indexPath.row])
            return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as! HeaderCollectionReusableView
        header.config(with: HomeViewmModel.shared.sections[indexPath.section].title)
        return header
    }
}


//MARK: - Home View Model Delegate Methods
extension HomeViewController {
    func errorOccured(error: String) {
//        mainCollectionView.isHidden = true
        errorLabel.textColor = .red
        errorLabel.text = error
    }
    
    func updateUI() {
        self.mainCollectionView.reloadData()
    }
}
//MARK: - Create Collection View Section Layout
extension HomeViewController {
    private static func createSectionLayout(index : Int) -> NSCollectionLayoutSection{
        let sectionHeaderLayout = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(50.0)
        ), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)

        switch index {
        case 0 :
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(120)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize:NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(360)
                ),
                repeatingSubitem: item,
                count: 5
            )
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.9),
                    heightDimension: .absolute(360)),
                repeatingSubitem: verticalGroup,
                count: 1
            )
            
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            section.boundarySupplementaryItems = [sectionHeaderLayout]
            return section
           //Section 2
        case 1 :
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 20, trailing: 3)
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.9),
                    heightDimension: .absolute(200)),
                repeatingSubitem: item,
                count: 2
            )
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.4),
                    heightDimension: .absolute(340)),
                repeatingSubitem: verticalGroup,
                count: 1
            )
            
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 3, bottom: 3, trailing: 3)
            section.boundarySupplementaryItems = [sectionHeaderLayout]
            
            return section
            
            //Section 3
        case 2 :
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
 
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(70)),
                repeatingSubitem: item,
                count: 1
            )
            sectionHeaderLayout.contentInsets = NSDirectionalEdgeInsets(top: 80, leading: 0, bottom: 50, trailing: 0)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 100, leading: 3, bottom: 3, trailing: 3)
            section.boundarySupplementaryItems = [sectionHeaderLayout]
            return section
            
        default :
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(120)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)

  
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.9),
                    heightDimension: .absolute(360)),
                repeatingSubitem: item,
                count: 1
            )
            
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            return section
        }
     
    }

}
