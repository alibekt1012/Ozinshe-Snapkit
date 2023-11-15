//
//  MovieTableViewCell.swift
//  Ozinshe_SnapKit
//
//  Created by Almat Alibekov on 14.11.2023.
//

import UIKit
import SDWebImage

class MovieTableViewCell: UITableViewCell {

    private lazy var posterImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private lazy var movieTitle: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(red: 0.07, green: 0.09, blue: 0.15, alpha: 1)
        return label
    }()
    
    private lazy var movieDetailsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        label.textColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1)
        return label
    }()
    
    private lazy var playView: UIView = {
        let view = UIView()
        let imageView = UIImageView()
        let label = UILabel()

        view.addSubview(imageView)
        view.addSubview(label)

        view.backgroundColor = UIColor(red: 0.97, green: 0.93, blue: 1, alpha: 1)
        view.layer.cornerRadius = 8

        imageView.image = UIImage(named: "play")

        label.text = "Қарау"
        label.textColor = UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1)
        label.font =  UIFont(name: "SFProDisplay-Bold", size: 12)

        imageView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(12)
            make.verticalEdges.equalToSuperview().inset(5)
            make.size.equalTo(16)
        }

        label.snp.makeConstraints { make in
            make.centerY.equalTo(imageView)
            make.left.equalTo(imageView.snp.right).offset(4)
            make.right.equalToSuperview().inset(12)
        }
        return view
    }()
    
    private lazy var separatorView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(red: 0.82, green: 0.84, blue: 0.86, alpha: 1)
        return view
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

        contentView.addSubviews(posterImageView, movieTitle, movieDetailsLabel, playView, separatorView)
    }
    
    func setupConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.leading.equalTo(24)
            make.top.equalTo(24)
            make.height.equalTo(104)
            make.width.equalTo(71)
        }
        
        movieTitle.snp.makeConstraints { make in
            make.left.equalTo(posterImageView.snp.right).offset(17)
            make.top.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
        }

        movieDetailsLabel.snp.makeConstraints { make in
            make.top.equalTo(movieTitle.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(movieTitle)
        }

        playView.snp.makeConstraints { make in
            make.top.equalTo(movieDetailsLabel.snp.bottom).offset(24)
            make.left.equalTo(movieDetailsLabel)
        }
        separatorView.snp.makeConstraints { make in
            make.leading.equalTo(24)
            make.trailing.equalTo(-24)
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
        }
    }
    
    func setupData(movie: Movie) {
        posterImageView.sd_setImage(with: URL(string: movie.poster_link))
        movieTitle.text = movie.name
        movieDetailsLabel.text = "\(movie.year)"
    }
    
}
