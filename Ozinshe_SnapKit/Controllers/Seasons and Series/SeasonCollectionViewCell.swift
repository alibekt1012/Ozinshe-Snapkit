//
//  SeasonCollectionViewCell.swift
//  Ozinshe_SnapKit
//
//  Created by Almat Alibekov on 30.11.2023.
//

import UIKit

class SeasonCollectionViewCell: UICollectionViewCell {
    
    private lazy var seasonBackgroundView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.96, alpha: 1)
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var seasonNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.22, green: 0.25, blue: 0.32, alpha: 1)
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
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
        contentView.addSubview(seasonBackgroundView)
        seasonBackgroundView.addSubview(seasonNumberLabel)
    }
    
    func setupConstraints() {
        seasonBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(34)
        }
        
        seasonNumberLabel.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.top.bottom.equalToSuperview()
        }
    }
    
    func setData(season: Season, currentSeason: Int) {
        seasonNumberLabel.text = "\(season.number) сезон"
        
        if currentSeason == season.number - 1 {
            seasonNumberLabel.textColor = UIColor(displayP3Red: 249/255, green: 250/255, blue: 251/255, alpha: 1)
            seasonBackgroundView.backgroundColor = UIColor(displayP3Red: 151/255, green: 83/255, blue: 240/255, alpha: 1)
        } else {
            seasonNumberLabel.textColor = UIColor(displayP3Red: 55/255, green: 65/255, blue: 81/255, alpha: 1)
            seasonBackgroundView.backgroundColor = UIColor(displayP3Red: 243/255, green: 244/255, blue: 246/255, alpha: 1)
        }
        
    }
    
}
