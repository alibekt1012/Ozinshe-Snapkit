//
//  LanguageTableViewCell.swift
//  Ozinshe_SnapKit
//
//  Created by Almat Alibekov on 08.11.2023.
//

import UIKit

class LanguageTableViewCell: UITableViewCell {

    private lazy var languageLabel: UILabel = {
       let label = UILabel()
        // label.text = "English"
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        label.textColor = UIColor(red: 0.07, green: 0.09, blue: 0.15, alpha: 1)
        return label
    }()
    
    private lazy var separatorView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(red: 0.82, green: 0.84, blue: 0.86, alpha: 1)
       return view
    }()
    
    private lazy var checkImage: UIImageView = {
       
        let image = UIImageView()
       // image.image = UIImage(named: "Check")
        return image
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
        contentView.addSubview(languageLabel)
        contentView.addSubview(separatorView)
        contentView.addSubview(checkImage)
    }
    
    func setupConstraints() {
        languageLabel.snp.makeConstraints { make in
            make.leading.equalTo(24)
            make.centerY.equalToSuperview()
        }
        
        separatorView.snp.makeConstraints { make in
            make.leading.equalTo(24)
            make.trailing.equalTo(-24)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
            
        }
        
        checkImage.snp.makeConstraints { make in
            make.trailing.equalTo(-24)
            make.centerY.equalToSuperview()
        }
    }
    
    func setupData(language: String, image: String) {
        languageLabel.text = language
        checkImage.image = UIImage(named: image)
        
    }
}
