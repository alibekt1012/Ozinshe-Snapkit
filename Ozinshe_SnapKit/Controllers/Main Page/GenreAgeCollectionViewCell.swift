//
//  GenreAgeCollectionViewCell.swift
//  Ozinshe_SnapKit
//
//  Created by Almat Alibekov on 23.11.2023.
//

import UIKit
import SDWebImage
import SnapKit

class GenreAgeCollectionViewCell: UICollectionViewCell {
    
    private lazy var posterImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.addSubviews(posterImageView, nameLabel)
    }
    
    func setupConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
            make.height.equalTo(112)
            make.width.equalTo(184)
        }
        nameLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.centerY.equalTo(posterImageView.snp.centerY)
        }
    }
    
    func setData(name: String, link: String) {
        posterImageView.sd_setImage(with: URL(string: link))
        
        nameLabel.text = name
    }
    
}
