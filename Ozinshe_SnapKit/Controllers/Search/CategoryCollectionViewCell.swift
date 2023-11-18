//
//  CategoryCollectionViewCell.swift
//  Ozinshe_SnapKit
//
//  Created by Almat Alibekov on 18.11.2023.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
        

    private lazy var cellView: UIView = {
       
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.96, alpha: 1)
        view.layer.cornerRadius = 8
        
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        label.textColor = UIColor(red: 0.22, green: 0.25, blue: 0.32, alpha: 1)
        view.addSubview(label)
        
        
        label.snp.makeConstraints { make in
            make.leading.equalTo(24)
            make.trailing.equalTo(-24)
            make.top.bottom.equalToSuperview()
        }
        label.tag = 1001
        return view
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(category: Category) {
        if let categoryTitle = cellView.viewWithTag(1001) as? UILabel {
            categoryTitle.text = category.name
            }
    }
    
    func setupViews() {
        contentView.addSubview(cellView)
        
    }
    
    func setupConstraints() {
        cellView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
            make.height.equalTo(34)
        }
    }
}
