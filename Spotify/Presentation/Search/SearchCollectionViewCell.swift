//
//  SreachCollectionViewCell.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 08/05/2024.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    static let identifier : String = "SearchCollectionViewCell"
 //MARK: - UIViews
    private var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        return imageView
    }()
    private var label : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    //MARK: - Built In Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = height / 2
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        label.text = nil
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: 0, y: 0, width: height, height: height)
        label.frame = CGRect(x: imageView.right + 10 , y: contentView.center.y, width: width, height: 20)
    }
    //MARK: - Functions
    func config(with model : SearchItemModel){
        imageView.sd_setImage(with: URL(string: model.imageURL), completed: nil)
        label.text = model.title
    }
    
}
