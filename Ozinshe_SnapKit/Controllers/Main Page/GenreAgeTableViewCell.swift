//
//  GenreAgeTableViewCell.swift
//  Ozinshe_SnapKit
//
//  Created by Almat Alibekov on 23.11.2023.
//

import UIKit

class GenreAgeTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var mainMovie = MainMovie()
    
    private lazy var genreAgeNameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textColor = UIColor(red: 0.07, green: 0.09, blue: 0.15, alpha: 1)
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        
        let layout = TopAlignedCollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24.0, bottom: 0, right: 24.0)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.estimatedItemSize.width = 184
        layout.estimatedItemSize.height = 112
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.register(GenreAgeCollectionViewCell.self, forCellWithReuseIdentifier: "GenreAgeCell")
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
    
    func setData(mainMovie: MainMovie) {
        
        self.mainMovie = mainMovie
        genreAgeNameLabel.text = self.mainMovie.categoryName
        collectionView.reloadData()
    }
    
    func setupViews() {
        contentView.addSubviews(genreAgeNameLabel, collectionView)
    }
    
    func setupConstraints() {
        
        genreAgeNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(24)
            make.trailing.equalTo(-24)
            make.top.equalTo(22)
        }
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(genreAgeNameLabel.snp.bottom).offset(16)
            make.bottom.equalTo(-10)
        }
    }

}

extension GenreAgeTableViewCell {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if mainMovie.cellType == .ageCategory {
            return mainMovie.categoryAges.count
        }
        return mainMovie.genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreAgeCell", for: indexPath) as! GenreAgeCollectionViewCell
        
        if mainMovie.cellType == .ageCategory {
            cell.setData(name: mainMovie.categoryAges[indexPath.row].name, link: mainMovie.categoryAges[indexPath.row].link)
        }
        if mainMovie.cellType == .genre {
            cell.setData(name: mainMovie.genres[indexPath.row].name, link: mainMovie.genres[indexPath.row].link)
        }
        
        return cell
    }
    
}
