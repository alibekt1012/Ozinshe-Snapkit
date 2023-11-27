//
//  MovieInfoViewController.swift
//  Ozinshe_SnapKit
//
//  Created by Almat Alibekov on 23.11.2023.
//

import UIKit
import SnapKit

class MovieInfoViewController: UIViewController {

   var scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 1000)
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
       let contentView = UIView()
        
        return contentView
    }()
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
         imageView.clipsToBounds = true
         imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "poster")
         return imageView
    }()
    
    private lazy var backButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "backButtonArrow"), for: .normal)
        return button
    }()
    
    private lazy var gradientView: Gradient = {
        let view = Gradient()
        view.startColor = .clear
        view.endColor = UIColor(red: 0.06, green: 0.09, blue: 0.11, alpha: 1.00)
        view.startLocation = 0
        view.endLocation = 1
        
        return view
    }()
    
    private lazy var playButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "playButton"), for: .normal)
        return button
    }()
    
    private lazy var favoriteButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "favoriteButton"), for: .normal)
        return button
    }()
    
    private lazy var favoriteLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        label.textColor = UIColor(red: 0.82, green: 0.84, blue: 0.86, alpha: 1)
        label.text = "Тізімге қосу"
        return label
    }()
    
    private lazy var shareButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "shareButton"), for: .normal)
        return button
    }()
    
    private lazy var shareLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        label.textColor = UIColor(red: 0.82, green: 0.84, blue: 0.86, alpha: 1)
        label.text = "Бөлісу"
        return label
    }()
    
    private lazy var movieInfoView: UIView = {
       let view = UIView()
        view.layer.cornerRadius = 32
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(red: 0.07, green: 0.09, blue: 0.15, alpha: 1)
        label.text = "Title"
        return label
    }()
    
    private lazy var yearLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        label.textColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1)
        label.text = "Description"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var divideView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(red: 0.82, green: 0.84, blue: 0.86, alpha: 1)
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1)
        label.text = "Шытырман оқиғалы мультсериал Елбасының «Ұлы даланың жеті қыры» бағдарламасы аясында жүзеге асырылған. Мақалада қызғалдақтардың отаны Қазақстан екені айтылады. Ал, жоба қызғалдақтардың отаны – Алатау баурайы екенін анимация тілінде дәлелдей түседі. Шытырман оқиғалы мультсериал Елбасының «Ұлы даланың жеті қыры» бағдарламасы аясында жүзеге асырылған. Мақалада қызғалдақтардың отаны Қазақстан екені айтылады. Ал, жоба қызғалдақтардың отаны – Алатау баурайы екенін анимация тілінде дәлелдей түседі.Шытырман оқиғалы мультсериал Елбасының «Ұлы даланың жеті қыры» бағдарламасы аясында жүзеге асырылған. Мақалада қызғалдақтардың отаны Қазақстан екені айтылады. Ал, жоба қызғалдақтардың отаны – Алатау баурайы екенін анимация тілінде дәлелдей түседі.Шытырман оқиғалы мультсериал Елбасының «Ұлы даланың жеті қыры» бағдарламасы аясында жүзеге асырылған. Мақалада қызғалдақтардың отаны Қазақстан екені айтылады. Ал, жоба қызғалдақтардың отаны – Алатау баурайы екенін анимация тілінде дәлелдей түседі. "
        label.numberOfLines = 30
        return label
    }()
    
    private lazy var descriptionGradientView: Gradient = {
        let view = Gradient()
        view.startColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.0)
        view.endColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.8)
        view.startLocation = 0.1
        view.endLocation = 1
        
        return view
    }()
    
    private lazy var fullDescriptionButton: UIButton = {
       let button = UIButton()
        button.setTitle("More", for: .normal)
        button.setTitleColor(UIColor(red: 0.7, green: 0.46, blue: 0.97, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        button.addTarget(self, action: #selector(expandDescription), for: .touchUpInside)
        return button
    }()
    
    private lazy var directorLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(red: 0.29, green: 0.33, blue: 0.39, alpha: 1)
        label.text = "Режиссер"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var producerLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(red: 0.29, green: 0.33, blue: 0.39, alpha: 1)
        label.text = "Продюсер"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var directorValueLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1)
        label.text = "Режиссер"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var producerValueLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1)
        label.text = "Продюсер"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var divideView2: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(red: 0.82, green: 0.84, blue: 0.86, alpha: 1)
        return view
    }()
    
    private lazy var seasonsLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1)
        label.text = "Бөлімдер"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var seasonSeriesButton: UIButton = {
       let button = UIButton()
        button.setTitle("5 сезон, 46 серия", for: .normal)
        button.setTitleColor(UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 60.0)
        return button
    }()
    
    private lazy var arrowImageView: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "arrow")
        image.contentMode = .scaleToFill
        return image
    }()
    
    
    
    var movie = Movie()
    var similarMovies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        
        if descriptionLabel.numberOfLines > 4 {
            descriptionLabel.numberOfLines = 4
            fullDescriptionButton.setTitle("Толығырақ", for: .normal)
            descriptionGradientView.isHidden = false
        }
    }
    
 
    
    func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(posterImageView, gradientView, backButton, playButton, shareButton, shareLabel, favoriteButton, favoriteLabel, movieInfoView)
        movieInfoView.addSubviews(titleLabel, yearLabel, divideView, descriptionLabel, descriptionGradientView, fullDescriptionButton, directorLabel, producerLabel, directorValueLabel, producerValueLabel, divideView2, seasonsLabel, seasonSeriesButton, arrowImageView)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        posterImageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(364)
        }
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(posterImageView.snp.top).offset(59)
            make.width.equalTo(95)
            make.height.equalTo(100)
        }
        gradientView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(posterImageView)
            make.top.equalTo(backButton.snp.top)
        }
        
        playButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(132)
            make.height.equalTo(132)
            make.top.equalTo(198)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.leading.equalTo(37)
            make.top.equalTo(228)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        favoriteLabel.snp.makeConstraints { make in
            make.centerX.equalTo(favoriteButton.snp.centerX)
            make.bottom.equalTo(favoriteButton.snp.bottom).offset(-32)
        }
        
        shareButton.snp.makeConstraints { make in
            make.trailing.equalTo(-37)
            make.top.equalTo(228)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        shareLabel.snp.makeConstraints { make in
            make.centerX.equalTo(shareButton.snp.centerX)
            make.bottom.equalTo(shareButton.snp.bottom).offset(-32)
        }
        
        movieInfoView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(324)
            make.height.equalTo(700)
            make.bottom.lessThanOrEqualToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalTo(24)
            make.trailing.equalTo(-24)

        }
        yearLabel.snp.makeConstraints { make in
            make.leading.equalTo(24)
            make.trailing.equalTo(-24)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        divideView.snp.makeConstraints { make in
            make.leading.equalTo(24)
            make.trailing.equalTo(-24)
            make.height.equalTo(1)
            make.top.equalTo(yearLabel.snp.bottom).offset(24)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(24)
            make.trailing.equalTo(-24)
            make.top.equalTo(divideView.snp.bottom).offset(24)
            
        }
        
        descriptionGradientView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(descriptionLabel.snp.top)
            make.bottom.equalTo(fullDescriptionButton.snp.top).offset(-11)
        }
        fullDescriptionButton.snp.makeConstraints { make in
            make.leading.equalTo(24)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
        }
        
        directorLabel.snp.makeConstraints { make in
            make.leading.equalTo(24)
            make.top.equalTo(fullDescriptionButton.snp.bottom).offset(24)
        }
        
        producerLabel.snp.makeConstraints { make in
            make.leading.equalTo(24)
            make.top.equalTo(directorLabel.snp.bottom).offset(24)
        }
        
        directorValueLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(113)
            make.trailing.equalTo(-24)
            make.top.equalTo(fullDescriptionButton.snp.bottom).offset(24)
        }
        
        producerValueLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(113)
            make.trailing.equalTo(-24)
            make.top.equalTo(directorLabel.snp.bottom).offset(24)
        }
        divideView2.snp.makeConstraints { make in
            make.leading.equalTo(24)
            make.trailing.equalTo(-24)
            make.height.equalTo(1)
            make.top.equalTo(producerLabel.snp.bottom).offset(24)
        }
        seasonsLabel.snp.makeConstraints { make in
            make.leading.equalTo(24)
            make.top.equalTo(divideView2.snp.bottom).offset(24)
        }
        seasonSeriesButton.snp.makeConstraints { make in
            make.leading.equalTo(seasonsLabel.snp.trailing)
            make.trailing.equalToSuperview()
            make.centerY.equalTo(seasonsLabel.snp.centerY)
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.trailing.equalTo(-24)
            make.width.equalTo(16)
            make.height.equalTo(16)
            make.centerY.equalTo(seasonSeriesButton.snp.centerY)
        }
        
        
    }
    
    @objc func expandDescription() {
        if descriptionLabel.numberOfLines > 4 {
            descriptionLabel.numberOfLines = 4
            fullDescriptionButton.setTitle("Толығырақ", for: .normal)
            descriptionGradientView.isHidden = false
        } else {
            descriptionLabel.numberOfLines = 30
            fullDescriptionButton.setTitle("Жасыру", for: .normal)
            descriptionGradientView.isHidden = true
        }
    }
    
    
}
