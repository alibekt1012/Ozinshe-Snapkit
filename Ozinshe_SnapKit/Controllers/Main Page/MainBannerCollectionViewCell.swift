//
//  MainBannerCollectionViewCell.swift
//  Ozinshe_SnapKit
//
//  Created by Almat Alibekov on 20.11.2023.
//

import UIKit

class MainBannerCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
    }
    
    func setupConstraints() {
        
    }
    
//    func setData(bannerMovie: BannerMovie) {
//        
//        bannerImageView.sd_setImage(with: URL(string: bannerMovie.link))
//
//        if let category = bannerMovie.movie.categories.first {
//            categoryLabel.text = category.name
//        }
//
//        titleLabel.text = bannerMovie.movie.name
//        descriptionLabel.text = bannerMovie.movie.description
//    }
}
