//
//  SearchResultsViewController.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 02/05/2024.
//

import UIKit
import SafariServices

protocol SearchResultsViewControllerDelegate : AnyObject{
    func didTapResult(_ result : SearchResultSections,_ index : Int)
}
class SearchResultsViewController: UIViewController  {
    //MARK: - Property
    
    weak var delegate : SearchResultsViewControllerDelegate?
    //MARK: - UIViews
    private var collectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { sectionProvider, _ in
            let sectionHeaderLayout = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(50.0)
            ), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            let section = SearchViewModel.shared.searchResult[sectionProvider]
            switch section {
            case .albums :
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalHeight(1))
                )
                item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .absolute(60)),
                    repeatingSubitem: item,
                    count: 2)
                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [sectionHeaderLayout]
                return section
            case .playlist :
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalHeight(1))
                )
                item.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 5, bottom: 15, trailing: 5)
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .absolute(60)),
                    repeatingSubitem: item,
                    count: 2)
                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [sectionHeaderLayout]
                return section
            case .tracks :
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalHeight(1))
                )
                item.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 5, bottom: 15, trailing: 5)
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .absolute(60)),
                    repeatingSubitem: item,
                    count: 2)
                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [sectionHeaderLayout]
                return section
            case .artists :
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalHeight(1))
                )
                item.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 5, bottom: 15, trailing: 5)
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .absolute(60)),
                    repeatingSubitem: item,
                    count: 2)
                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [sectionHeaderLayout]
                return section
            }
     
        }))
        return collectionView
    }()
    //MARK: - Built In Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        SearchViewModel.shared.delegate = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    //MARK: - Functions
    private func configCollectionView(){
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)

    }
    func updateController() {
        collectionView.reloadData()
    }
    

}
extension SearchResultsViewController : UICollectionViewDelegate , UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        print("num of sections : \(SearchViewModel.shared.searchResult.count)")
        return SearchViewModel.shared.searchResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = SearchViewModel.shared.searchResult[section]
        switch section{
        case .albums(let model) : return model.count
        case .playlist(let model) :return model.count
        case .tracks(let model) : return model.count
        case .artists(let model) : return model.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = SearchViewModel.shared.searchResult[indexPath.section]
        switch section{
        case .albums(let model) :
            let album = model[indexPath.row]
            let searchItemModel = SearchItemModel(imageURL: album.images?.first?.url ?? "", title: album.name ?? "")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as! SearchCollectionViewCell
            cell.config(with: searchItemModel)
            return cell
        case .playlist(let model) :
            let playlist = model[indexPath.row]
            let searchItemModel = SearchItemModel(imageURL: playlist.images?.first?.url ?? "", title: playlist.name )
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as! SearchCollectionViewCell
            cell.config(with: searchItemModel)
            return cell
        case .tracks(let model) :
            let track = model[indexPath.row]
            let searchItemModel = SearchItemModel(imageURL: track.album?.images?.first?.url ?? "" , title: track.name )
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as! SearchCollectionViewCell
            cell.config(with: searchItemModel)
            return cell
        case .artists(let model) :
            let artist = model[indexPath.row]
            let searchItemModel = SearchItemModel(imageURL: artist.images?.first?.url ?? "", title: artist.name )
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as! SearchCollectionViewCell
            cell.config(with: searchItemModel)
            return cell
        }
      
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let searchResult = SearchViewModel.shared.searchResult[indexPath.section]
        let index = indexPath.row
        self.delegate?.didTapResult(searchResult,index)
   
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as! HeaderCollectionReusableView
        header.config(with: SearchViewModel.shared.searchResult[indexPath.row].title)
        return header
    }
    
    
}

extension SearchResultsViewController : SearchViewModelDelegate{
    func didTapResult(searchResult: SearchResultSections, index: Int) {
        
    }
    
    func updateUI() {
        self.collectionView.reloadData()
    }
    
    func errorOccured(with error: String) {
        Utilities.errorALert(message: error, actionTitle: nil, action: {}, vc: self)
    }
    
}
