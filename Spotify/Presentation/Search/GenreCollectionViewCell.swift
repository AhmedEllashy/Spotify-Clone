//
//  GenreCollectionViewCell.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 03/05/2024.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    static let identifier : String = "GenreCollectionViewCell"
    
    let colors : [UIColor] = [
        .systemRed,
        .systemOrange,
        .systemYellow,
        .systemGreen,
        .systemTeal,
        .systemPink,
        .systemCyan,
        .systemMint,
        .systemPurple,
        .systemBrown
        
    ]
    //MARK: - UIViews
    private var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.image = UIImage(systemName: "music.quarternote.3",withConfiguration: UIImage.SymbolConfiguration(pointSize: 10, weight: .medium))
        return imageView
    }()
    private var genraNameLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "Music"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(genraNameLabel)
        contentView.layer.cornerRadius = 10.0
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        configSubViews()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        genraNameLabel.text = nil
    }
    //MARK: - Functions
     func config(with title : String){
        genraNameLabel.text = title
        contentView.backgroundColor = colors.randomElement()
    }
    private func configSubViews(){
        imageView.frame = CGRect(x: width - 70, y: 10, width: 50, height: 50)
        genraNameLabel.frame = CGRect(x: 10, y: height - 40, width: width, height: 25)
    }
}
