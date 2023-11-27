//
//  HistoryCollectionViewCell.swift
//  Ozinshe_SnapKit
//
//  Created by Almat Alibekov on 22.11.2023.
//

import UIKit
import SDWebImage
import SnapKit

class HistoryCollectionViewCell: UICollectionViewCell {
    
    private lazy var posterImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        label.textColor = UIColor(red: 0.07, green: 0.09, blue: 0.15, alpha: 1)
        return label
    }()
    
    private lazy var categoryLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        label.textColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1)
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
        contentView.addSubviews(posterImageView, nameLabel, categoryLabel)
    }
    
    func setupConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.width.equalTo(184)
            make.height.equalTo(112)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(posterImageView.snp.bottom).offset(8)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
        }
    }
    
    func setData(movie: Movie) {
        posterImageView.layer.cornerRadius = 8
        
        posterImageView.sd_setImage(with: URL(string: movie.poster_link))
        
        nameLabel.text = movie.name
        
        if let genre = movie.genres.first {
            categoryLabel.text = genre.name
        } else {
            categoryLabel.text = ""
        }
    }
}
