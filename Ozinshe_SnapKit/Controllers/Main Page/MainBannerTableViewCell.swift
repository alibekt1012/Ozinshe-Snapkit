//
//  MainBannerTableViewCell.swift
//  Ozinshe_SnapKit
//
//  Created by Almat Alibekov on 20.11.2023.
//

import UIKit

class MainBannerTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
   
    var mainMovie = MainMovie()
    
    private lazy var collectionView: UICollectionView = {
        
        let layout = TopAlignedCollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24.0, bottom: 0, right: 24.0)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.estimatedItemSize.width = 300
        layout.estimatedItemSize.height = 240
        layout.scrollDirection = .horizontal
        
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        //cv.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCell")
        return cv
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
        contentView.addSubview(collectionView)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }

}

extension MainBannerTableViewCell {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainMovie.bannerMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
}
