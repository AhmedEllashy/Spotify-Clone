//
//  FeaturedPlaylistsCollectionViewCell.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 22/04/2024.
//

import UIKit
import SDWebImage
class FeaturedPlaylistsCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    static let cellIdentifier : String = "FeaturedPlaylistsCollectionViewCell"
    
    //MARK: - UIViews
    private  var playlistImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        return imageView
    }()
    private var playlistNameLabel : UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    private var creatorNameLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textAlignment = .center
        return label
    }()
    //MARK: - Built In Methdos
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(playlistImageView)
        contentView.addSubview(playlistNameLabel)
        contentView.addSubview(creatorNameLabel)
    }
    required init?(coder: NSCoder) {
        fatalError("Ellashy Error")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        playlistImageView.image = nil
        playlistNameLabel.text = nil
        creatorNameLabel.text = nil
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        configUIViews()
        
    }
    //MARK: - Fuctions
    func config(_ model : Playlist){
        playlistImageView.sd_setImage(with: URL(string: model.images?[0].url ?? ""), completed: nil)
        playlistNameLabel.text = model.name
        creatorNameLabel.text = model.owner.display_name
    }
    private func configUIViews(){
        contentView.clipsToBounds = true
        playlistImageView.backgroundColor = .black
        playlistImageView.frame = CGRect(x: 0, y: contentView.top + 2, width: contentView.width / 1.2, height: contentView.width / 1.2)

        playlistNameLabel.frame = CGRect(x: 0, y: Int(playlistImageView.bottom) + 10 , width: Int(contentView.width), height: 20)
        creatorNameLabel.frame = CGRect(x: 0, y: playlistNameLabel.bottom + 5, width: contentView.width, height: 20)
        playlistImageView.center.x = contentView.center.x



    }
    

}
