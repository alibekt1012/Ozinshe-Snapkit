//
//  MainBannerTableViewCell.swift
//  Ozinshe_SnapKit
//
//  Created by Almat Alibekov on 20.11.2023.
//

import UIKit

class MainBannerTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
   
    var mainMovie = MainMovie()
    var delegate: MovieProtocol?
    
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
        cv.register(MainBannerCollectionViewCell.self, forCellWithReuseIdentifier: "BannerCell")
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
    
    func setData(mainMovie: MainMovie) {
        self.mainMovie = mainMovie
        
        collectionView.reloadData()
    }

}

extension MainBannerTableViewCell {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainMovie.bannerMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! MainBannerCollectionViewCell
        cell.setData(bannerMovie: mainMovie.bannerMovie[indexPath.row])
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.movieDidSelect(movie: mainMovie.bannerMovie[indexPath.item].movie)
    }

    
}
