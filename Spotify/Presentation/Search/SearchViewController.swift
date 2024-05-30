//
//  SearchViewController.swift
//  Spotify Clone
//
//  Created by Ahmad Ellashy on 23/03/2024.
//

import UIKit
import SafariServices
class SearchViewController: UIViewController, UISearchResultsUpdating ,UISearchBarDelegate{

    
    private let categoryViewModel : CategoryViewModel = CategoryViewModel.shared
    private let searchViewModel : SearchViewModel = SearchViewModel.shared
    //MARK: - Properties
    private let searchController : UISearchController = {
        let vc = UISearchController(searchResultsController: SearchResultsViewController())
        vc.searchBar.placeholder = "Albums, Songs, Artists"
        vc.searchBar.searchBarStyle = .minimal
        return vc
    }()
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
                    heightDimension: .absolute(130)),
                repeatingSubitem: item,
                count: 2)
            return NSCollectionLayoutSection(group: group)
        }))
        return collectionView
    }()
  
    //MARK: - Built In Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    //MARK: - SearchBar Methods

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let vc = searchController.searchResultsController as? SearchResultsViewController else{
            return
        }
        guard let query = searchBar.text else{
            return
        }
        searchViewModel.search(with: query)
        vc.delegate = self
        
    }
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
      
        searchViewModel.searchResult.removeAll()
        
        
    }
    
    //MARK: - Function
    private func setup(){
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Search"
        navigationItem.searchController = searchController
        self.searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: GenreCollectionViewCell.identifier)
        categoryViewModel.delegate = self
        categoryViewModel.getCategories()
        
    }

    


}
extension SearchViewController : UICollectionViewDelegate , UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryViewModel.categories.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let category = categoryViewModel.categories[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionViewCell.identifier, for: indexPath) as! GenreCollectionViewCell
        cell.config(with: category)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let vc = CategoryPlaylistViewController(category: categoryViewModel.categories[indexPath.row])
        vc.title = categoryViewModel.categories[indexPath.row].name
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    
}

extension SearchViewController : CategoryViewModelDelegate {
    func updateUI() {
        self.collectionView.reloadData()
    }
    func errorOccured(with error: String) {
        Utilities.errorALert(title: "Ooops", message: error, actionTitle: nil, action: {}, vc: self)
    }
}
extension SearchViewController : SearchResultsViewControllerDelegate {
    func didTapResult(_ result: SearchResultSections, _ index : Int) {
        switch result {
        case .albums(let model) :
            let vc = AlbumViewController(album: model[index])
            vc.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(vc, animated: true)
        case .playlist(let model) :
            let vc = PlaylistViewController(playlist: model[index])
            vc.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(vc, animated: true)
        case .tracks(let model) :
            let track = model[index]
            PlayerViewModel.shared.playTrack(track: track, vc: self)
            
        case .artists(let model):
            guard let url = URL(string: model[index].external_urls["spotify"] ?? "") else{
                return
            }
            let vc = SFSafariViewController(url: url)
            self.present(vc,animated: true)

        }
    }
    

    
    
}
