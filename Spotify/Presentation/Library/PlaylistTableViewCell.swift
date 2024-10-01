//
//  PlaylistTableViewCell.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 31/05/2024.
//

import UIKit
import SDWebImage

class PlaylistTableViewCell: UITableViewCell {
    static let identifier : String = "PlaylistTableViewCell"
    private var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    private var descriptionLabel : UILabel = {
        let label = UILabel()
        label.text = "playlist"
        label.textColor = .secondaryLabel
        return label
    }()
    private var playlistImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.clipsToBounds = true
        return imageView
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "PlaylistTableViewCell")
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(playlistImageView)

    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        playlistImageView.frame = CGRect(x: 10, y: 0, width: height, height: height - 10)
        playlistImageView.layer.cornerRadius = 10
        print(top)
        titleLabel.frame = CGRect(x: playlistImageView.right + 10, y: 5, width: 100, height: 30)
        descriptionLabel.frame = CGRect(x: playlistImageView.right + 10, y: titleLabel.bottom + 5 , width: 100, height: 20)
    }
    func config(with imageURL : String, and title : String){
        playlistImageView.sd_setImage(with: URL(string: imageURL ?? ""), placeholderImage: UIImage(systemName: "photo"))
        titleLabel.text = title
    }
}
