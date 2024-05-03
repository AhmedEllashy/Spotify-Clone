//
//  NewReleasesCollectionViewCell.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 22/04/2024.
//

import UIKit

class NewReleasesCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    static let cellIdentifier : String = "NewReleasesCollectionViewCell"
    
    
    //MARK: - UIElements
    private var albumImageView : UIImageView =  {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var albumNameLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    private var numberOfTracksLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    private var artistNameLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    //MARK: - Built In Methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        albumImageView.image = nil
        albumNameLabel.text = nil
        numberOfTracksLabel.text = nil
        artistNameLabel.text = nil
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(albumImageView)
        contentView.addSubview(albumNameLabel)
        contentView.addSubview(numberOfTracksLabel)
        contentView.addSubview(artistNameLabel)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        configViewsLayout()
    }
    
    //MARK: - Functions
     func config(_ model : Album){
        albumImageView.sd_setImage(with: URL(string: model.images[0].url), completed: nil)
        albumNameLabel.text = model.name
        numberOfTracksLabel.text = "Tracks: \(model.total_tracks)"
        artistNameLabel.text = model.artists[0].name
        
    }
    private func configViewsLayout(){
        //Image
        contentView.clipsToBounds = true
        albumImageView.frame = CGRect(x: 0, y: 0, width:contentView.height , height: contentView.height)
        albumNameLabel.frame = CGRect(x: albumImageView.right + 10, y: contentView.top , width: contentView.width - albumImageView.width, height: 30)
        artistNameLabel.frame = CGRect(x: albumImageView.right + 10, y: albumNameLabel.bottom + 10, width: contentView.width - albumImageView.width, height: 20)
        numberOfTracksLabel.frame = CGRect(x: albumImageView.right + 10, y: contentView.bottom - 30, width: contentView.width - albumImageView.width, height: 20)
    }
}
