//
//  HistoryTableViewCell.swift
//  Ozinshe_SnapKit
//
//  Created by Almat Alibekov on 22.11.2023.
//

import UIKit

class HistoryTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    var mainMovie = MainMovie()
    var delegate: MovieProtocol?
    
    private lazy var collectionView: UICollectionView = {
        
        let layout = TopAlignedCollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24.0, bottom: 0, right: 24.0)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.estimatedItemSize.width = 184
        layout.estimatedItemSize.height = 156
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.register(HistoryCollectionViewCell.self, forCellWithReuseIdentifier: "HistoryCell")
        
        return cv
    }()
    
    private lazy var historyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textColor = UIColor(red: 0.07, green: 0.09, blue: 0.15, alpha: 1)
        label.text = "Қарауды жалғастырамыз"
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
        contentView.addSubviews(historyLabel, collectionView)
    }
    
    func setupConstraints() {
        historyLabel.snp.makeConstraints { make in
            make.top.equalTo(22)
            make.leading.equalTo(24)
            make.trailing.equalTo(-24)
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(historyLabel.snp.bottom).offset(16)
        }
    }
    
    func setData(mainMovie: MainMovie) {
   
        self.mainMovie = mainMovie
        
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.movieDidSelect(movie: mainMovie.movies[indexPath.item])
    }

}

extension HistoryTableViewCell {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainMovie.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HistoryCell", for: indexPath) as! HistoryCollectionViewCell
        
        cell.setData(movie: mainMovie.movies[indexPath.row])
        
        return cell
    }
    
}
