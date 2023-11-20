//
//  MainTableViewCell.swift
//  Ozinshe_SnapKit
//
//  Created by Almat Alibekov on 20.11.2023.
//

import UIKit
import SnapKit


protocol MovieProtocol {
    func movieDidSelect (movie: Movie)
}

class TopAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)?
            .map { $0.copy() } as? [UICollectionViewLayoutAttributes]

        attributes?
            .reduce([CGFloat: (CGFloat, [UICollectionViewLayoutAttributes])]()) {
                guard $1.representedElementCategory == .cell else { return $0 }
                return $0.merging([ceil($1.center.y): ($1.frame.origin.y, [$1])]) {
                    ($0.0 < $1.0 ? $0.0 : $1.0, $0.1 + $1.1)
                }
            }
            .values.forEach { minY, line in
                line.forEach {
                    $0.frame = $0.frame.offsetBy(
                        dx: 0,
                        dy: minY - $0.frame.origin.y
                    )
                }
            }

        return attributes
    }
}

class MainTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
   
    var mainMovie = MainMovie()
    
    private lazy var collectionView: UICollectionView = {
        
        let layout = TopAlignedCollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24.0, bottom: 0, right: 24.0)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.estimatedItemSize.width = 112
        layout.estimatedItemSize.height = 220
        layout.scrollDirection = .horizontal
        
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCell")
        return cv
    }()
    
    private lazy var categoryNameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textColor = UIColor(red: 0.07, green: 0.09, blue: 0.15, alpha: 1)
        return label
    }()
    
    private lazy var expandLabel: UILabel = {
       let label = UILabel()
        label.text = "Барлығы"
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        label.textColor = UIColor(red: 0.7, green: 0.46, blue: 0.97, alpha: 1)
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
    
    func setData(mainMovie: MainMovie) {
        categoryNameLabel.text = mainMovie.categoryName
        
        self.mainMovie = mainMovie
    }
    
    func setupViews() {
        contentView.addSubviews(categoryNameLabel, expandLabel, collectionView)
    }
    
    func setupConstraints() {
        
        categoryNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(24)
            make.top.equalTo(22)
        }
        
        expandLabel.snp.makeConstraints { make in
            make.leading.equalTo(categoryNameLabel.snp.trailing).offset(10)
            make.trailing.equalTo(-24)
            make.top.equalTo(22)
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(categoryNameLabel.snp.bottom)
            make.bottom.equalToSuperview().offset(10)
        }
    }

}

extension MainTableViewCell {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainMovie.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
        cell.setData(movie: mainMovie.movies[indexPath.item])
        
        return cell
    }
    
}
