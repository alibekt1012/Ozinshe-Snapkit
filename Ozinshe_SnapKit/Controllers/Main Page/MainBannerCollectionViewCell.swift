//
//  MainBannerCollectionViewCell.swift
//  Ozinshe_SnapKit
//
//  Created by Almat Alibekov on 20.11.2023.
//

import UIKit
import SDWebImage

class MainBannerCollectionViewCell: UICollectionViewCell {
    
    private lazy var bannerCategoryView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(red: 0.5, green: 0.18, blue: 0.99, alpha: 1)
        view.layer.cornerRadius = 8
        let categoryLabel = UILabel()
        categoryLabel.font = UIFont(name: "SFProDisplay-Medium", size: 12)
        categoryLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        categoryLabel.tag = 1001
        view.addSubview(categoryLabel)
        
        categoryLabel.snp.makeConstraints { make in
            make.leading.equalTo(8)
            make.trailing.equalTo(-8)
            make.centerY.equalToSuperview()
        }
        
        return view
    }()
    
    private lazy var bannerImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(red: 0.07, green: 0.09, blue: 0.15, alpha: 1)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        label.textColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1)
        label.numberOfLines = 2
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
        contentView.addSubviews(bannerImageView, bannerCategoryView, titleLabel, descriptionLabel)
    }
    
    func setupConstraints() {
        bannerCategoryView.snp.makeConstraints { make in
            make.leading.equalTo(8)
            make.top.equalTo(8)
            make.height.equalTo(24)
        }
        bannerImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(164)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(bannerImageView.snp.bottom).offset(16)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
        }
    }
    
    func setData(bannerMovie: BannerMovie) {
        
        bannerImageView.sd_setImage(with: URL(string: bannerMovie.link))

        if let category = bannerMovie.movie.categories.first {
            
            if let categoryLabel = bannerCategoryView.viewWithTag(1001) as? UILabel {
                categoryLabel.text = category.name
            }
        }

        titleLabel.text = bannerMovie.movie.name
        descriptionLabel.text = bannerMovie.movie.description
    }
}
