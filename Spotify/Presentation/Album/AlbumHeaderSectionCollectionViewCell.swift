//
//  AlbumHeaderSectionCollectionViewCell.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 30/04/2024.
//

import UIKit

final class AlbumHeaderSectionCollectionViewCell : UICollectionViewCell {
    //MARK: - Properties
    static var cellIdentifier : String = "AlbumHeaderSectionCollectionViewCell"
    
    
    //MARK: - UIViews
    private var albumImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        return imageView
    }()
    private var albumNameLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    private var releaseDateLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .light)
        return label
    }()
    private var artistNameLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()
    //MARK: - Built In Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(albumImageView)
        contentView.addSubview(albumNameLabel)
        contentView.addSubview(releaseDateLabel)
        contentView.addSubview(artistNameLabel)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        albumImageView.image = nil
        albumNameLabel.text = nil
        releaseDateLabel.text = nil
        artistNameLabel.text = nil
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        configUIViews()
    }

    //MARK: - Functions
    func config(_ model : AlbumDetails?){
        albumImageView.sd_setImage(with: URL(string:model?.images[0].url ?? ""), completed: nil)
        albumNameLabel.text = model?.name
        releaseDateLabel.text = "Release Date: " + (String.formateDate(for: model?.release_date ?? "") )
        artistNameLabel.text = model?.artists[0].name
    }
    private func configUIViews(){
        albumImageView.frame = CGRect(x: 0, y: contentView.top + 20 , width: contentView.width / 2, height: contentView.width / 2)
        albumNameLabel.frame = CGRect(x: 8, y: albumImageView.bottom + 10, width: contentView.width - 40, height: 30)
        releaseDateLabel.frame = CGRect(x: 8, y: albumNameLabel.bottom + 10, width: contentView.width - 40, height: 30)
        artistNameLabel.frame = CGRect(x: 8, y: releaseDateLabel.bottom + 10, width: contentView.width - 40, height: 30)
        albumImageView.center.x = contentView.center.x
    }


    
}

    

