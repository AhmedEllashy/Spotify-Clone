//
//  HeaderSectionCollectionViewCell.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 27/04/2024.
//

import UIKit
import SDWebImage
protocol HeaderSectionCollectionViewCellDelegate : AnyObject {
    func didTapPlayAllCollectionViewCellDelegate()
}
class HeaderSectionCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    static let cellIdentifier = "HeaderSectionCollectionViewCell"
    weak var delegate : HeaderSectionCollectionViewCellDelegate?
    //MARK: - UIViews
    private var playlistImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private var playlistNameLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    private var playlistDescriptionLabel : UILabel = {
        let label = UILabel()
        label.text = "Swung To raw op"
        label.font = .systemFont(ofSize: 16, weight: .light)
        return label
    }()
    private var playlistOwnerLabel : UILabel = {
        let label = UILabel()
        label.text = "Spotify"
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()
    private var playAllButton : UIButton = {
       let button = UIButton()
        let image = UIImage(systemName: "play.fill")
        button.setImage(image, for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        return button
    }()
    //MARK: - Built In Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(playlistImageView)
        contentView.addSubview(playlistNameLabel)
        contentView.addSubview(playlistDescriptionLabel)
        contentView.addSubview(playlistOwnerLabel)
        contentView.addSubview(playAllButton)
        playAllButton.addTarget(self, action: #selector(didTapPlayAll), for: .touchUpInside)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        playlistImageView.image = nil
        playlistNameLabel.text = nil
        playlistDescriptionLabel.text = nil
        playlistOwnerLabel.text = nil
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        configUIViews()
    }

    //MARK: - Functions
    func config(_ model : PlaylistDetailsResponse){
        playlistImageView.sd_setImage(with: URL(string:model.images[0].url), completed: nil)
        if model.description.isEmpty {
            playlistDescriptionLabel.text = "It's beautiful Albums !!"

        }else{
            playlistDescriptionLabel.text = model.description
        }
        playlistNameLabel.text = model.name
        playlistOwnerLabel.text = model.owner.display_name
    }
    private func configUIViews(){
        playlistImageView.frame = CGRect(x: 0, y: contentView.safeAreaInsets.top + 20 , width: contentView.width , height: contentView.width / 2)
        playlistNameLabel.frame = CGRect(x: 8, y: playlistImageView.bottom + 10, width: contentView.width - 40, height: 30)
        playlistDescriptionLabel.frame = CGRect(x: 8, y: playlistNameLabel.bottom + 10, width: contentView.width - 40, height: 30)
        playlistOwnerLabel.frame = CGRect(x: 8, y: playlistDescriptionLabel.bottom + 5, width: contentView.width - 40, height: 30)
        playlistImageView.center.x = contentView.center.x
        playAllButton.frame = CGRect(x: contentView.right - 60 , y: height - 60, width: 50, height: 50)
    }

    @objc func didTapPlayAll(){
        self.delegate?.didTapPlayAllCollectionViewCellDelegate()
    }
    
}
