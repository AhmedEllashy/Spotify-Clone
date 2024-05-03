//
//  SearchViewController.swift
//  Spotify Clone
//
//  Created by Ahmad Ellashy on 23/03/2024.
//

import UIKit

class SearchViewController: UIViewController, UISearchResultsUpdating{
  
    
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
    //MARK: - Search Resukt Updating
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text 
                , !query.trimmingCharacters(in: .whitespaces).isEmpty,
              let resultController = searchController.searchResultsController as? SearchResultsViewController else{
            return
        }
        print("updated")
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    //MARK: - Function
    private func setup(){
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Search"
        navigationItem.searchController = searchController
        self.searchController.searchResultsUpdater = self
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: GenreCollectionViewCell.identifier)
    }

    


}
extension SearchViewController : UICollectionViewDelegate , UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionViewCell.identifier, for: indexPath) as! GenreCollectionViewCell
        cell.config(with: "Rap")
        return cell
    }
    
    
}
