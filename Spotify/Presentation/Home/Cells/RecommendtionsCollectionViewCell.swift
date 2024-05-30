//
//  RecommendtionsCollectionViewCell.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 22/04/2024.
//

import UIKit
import SDWebImage

class RecommendtionsCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    static let cellIdentifier : String = "RecommendtionsCollectionViewCell"
    private var hasImage : Bool = true
    //MARK: - UIViews
    private var trackImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        return imageView
    }()
    private var trackNameLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    private var artistNameLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    //MARK: - Built In Methdos
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(trackImageView)
        contentView.addSubview(trackNameLabel)
        contentView.addSubview(artistNameLabel)
        
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        trackImageView.image = nil
        trackNameLabel.text = nil
        artistNameLabel.text = nil
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        configUIViews()
        contentView.backgroundColor = .secondarySystemBackground
    }
    
    //MARK: - Functions
    func config(_ model : Track?){
        if  model?.album != nil {
            trackImageView.sd_setImage(
                with: URL(string: model?.album?.images?[0].url ?? ""),
                completed: nil
            )
        }else{
            hasImage = false
        }
        trackNameLabel.text = model?.name
        artistNameLabel.text = model?.artists[0].name
    }
    private func configUIViews(){
        contentView.clipsToBounds = true
        if hasImage {
            trackImageView.frame = CGRect(x: 0, y: 0, width: contentView.height, height: contentView.height)
            trackNameLabel.frame = CGRect(x: trackImageView.right + 10, y: contentView.top , width: contentView.width - 200, height: 30)
            artistNameLabel.frame = CGRect(x: trackImageView.right + 10, y: trackNameLabel.bottom , width: contentView.width - 10, height: 20)
        }else{
            trackNameLabel.frame = CGRect(x: 10, y: contentView.top , width: contentView.width - 200, height: 30)
            artistNameLabel.frame = CGRect(x: 10, y: contentView.bottom - 30 , width: contentView.width - 10, height: 20)
        }
 
    }
}
