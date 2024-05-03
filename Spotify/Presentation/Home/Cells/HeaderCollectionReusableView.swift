//
//  HeaderCollectionReusableView.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 02/05/2024.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    //MARK: - Properties
    static let identifier : String = "SectionHeaderResuableView"
    
    //MARK: - UIViews
    private var titleLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        return label
    }()
    //MARK: - Built In Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRect(x: 10, y: 0, width: width, height: height)
    }
    //MARK: - Functions
    func config(with title : String) {
        titleLabel.text = title
    }

}
