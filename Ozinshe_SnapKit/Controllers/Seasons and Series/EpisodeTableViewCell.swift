//
//  EpisodeTableViewCell.swift
//  Ozinshe_SnapKit
//
//  Created by Almat Alibekov on 30.11.2023.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {
    
    
    private lazy var previewImageView: UIImageView = {
       let iv = UIImageView()
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
        iv.contentMode = .scaleToFill
        return iv
    }()
    private lazy var episodeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.07, green: 0.09, blue: 0.15, alpha: 1)
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.addSubviews(previewImageView, episodeLabel)
    }
    
    func setupConstraints() {
        previewImageView.snp.makeConstraints { make in
            make.leading.equalTo(24)
            make.trailing.equalTo(-24)
            make.top.equalTo(16)
            make.height.equalTo(178)
        }
        
        episodeLabel.snp.makeConstraints { make in
            make.leading.equalTo(24)
            make.trailing.equalTo(-24)
            make.top.equalTo(previewImageView.snp.bottom).offset(8)
        }
    }
    
    func setData(series: Series) {
        episodeLabel.text = "\(series.number) - ші бөлім"
        previewImageView.sd_setImage(with: URL(string: "https://img.youtube.com/vi/\(series.link)/hqdefault.jpg"))
    }


}
