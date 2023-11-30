//
//  MovieInfoViewController.swift
//  Ozinshe_SnapKit
//
//  Created by Almat Alibekov on 23.11.2023.
//

import UIKit
import SnapKit
import SVProgressHUD
import SwiftyJSON
import Alamofire

class MovieInfoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
  
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
        button.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
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
       // button.addTarget(self, action: #selector(addToFavorite), for: .touchUpInside)
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
        button.addTarget(self, action: #selector(shareButtonAction), for: .touchUpInside)
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
        label.numberOfLines = 4
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
        label.textColor = UIColor(red: 0.07, green: 0.09, blue: 0.15, alpha: 1)
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
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -48.0, bottom: 0, right: 0)
        return button
    }()
    
    private lazy var arrowImageView: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "arrow")
        image.contentMode = .scaleToFill
        return image
    }()
    
    private lazy var screenshotslabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textColor = UIColor(red: 0.07, green: 0.09, blue: 0.15, alpha: 1)
        label.text = "Скриншоттар"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var screenshotsCollectionView: UICollectionView = {
        
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
        cv.register(ScreenshotCollectionViewCell.self, forCellWithReuseIdentifier: "ScreenshotCell")
        
        return cv
    }()
    
    
    private lazy var sameContentLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textColor = UIColor(red: 0.07, green: 0.09, blue: 0.15, alpha: 1)
        label.text = "Ұқсас телехикаялар"
        label.numberOfLines = 0
        return label
    }()
    
    
    private lazy var sameContentCollectionView: UICollectionView = {
        
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
        cv.register(SameContentCollectionViewCell.self, forCellWithReuseIdentifier: "SameContentCell")
        return cv
    }()
    
    
    var movie = Movie()
    var similarMovies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setData()
        
        view.backgroundColor = .white
  
        if movie.movieType == "MOVIE" {
            seasonsLabel.isHidden = true
            seasonSeriesButton.isHidden = true
            arrowImageView.isHidden = true
            
            screenshotslabel.snp.makeConstraints { make in
                make.leading.equalTo(24)
                make.top.equalTo(divideView2.snp.bottom).offset(32)
            }
            
        } else {

        }
        if movie.favorite {
            favoriteButton.setImage(UIImage(named: "favoriteButtonSelected"), for: .normal)

        } else {
            favoriteButton.setImage(UIImage(named: "favoriteButton"), for: .normal)
        }
       
        if descriptionLabel.actualNumberOfLines < 5 {
            fullDescriptionButton.isHidden = true
            descriptionGradientView.isHidden = true
        } else {
            fullDescriptionButton.isHidden = false
            descriptionGradientView.isHidden = false
        }
          
        downloadSimilar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

 
    
    func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(posterImageView, gradientView, backButton, playButton, shareButton, shareLabel, favoriteButton, favoriteLabel, movieInfoView)
        movieInfoView.addSubviews(titleLabel, yearLabel, divideView, descriptionLabel, descriptionGradientView, fullDescriptionButton, directorLabel, producerLabel, directorValueLabel, producerValueLabel, divideView2, seasonsLabel, seasonSeriesButton, arrowImageView, screenshotslabel, screenshotsCollectionView, sameContentLabel, sameContentCollectionView)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-60)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(sameContentCollectionView.snp.bottom).offset(16)
        }
        contentView.snp.makeConstraints { make in
            make.edges.width.equalTo(scrollView)
          
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
        
        screenshotslabel.snp.makeConstraints { make in
            make.leading.equalTo(24)
            make.top.equalTo(seasonSeriesButton.snp.bottom).offset(32)
        }

        screenshotsCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(112)
            make.top.equalTo(screenshotslabel.snp.bottom).offset(16)
        }

        sameContentLabel.snp.makeConstraints { make in
            make.leading.equalTo(24)
            make.top.equalTo(screenshotsCollectionView.snp.bottom).offset(24)
        }
        sameContentCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(sameContentLabel.snp.bottom).offset(16)
            make.height.equalTo(224)
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
    
    @objc func shareButtonAction() {
        let text = "\(movie.name) \n\(movie.description)"
                let image = posterImageView.image
                let shareAll = [text, image!] as [Any]
                let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view
                self.present(activityViewController, animated: true, completion: nil)
    }
    
    @objc func backButtonAction() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func addToFavorite(_ sender: Any) {
        SVProgressHUD.setContainerView(self.view)
        SVProgressHUD.show()

        var method = HTTPMethod.post
        if movie.favorite {
            method = .delete
        }

        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(Storage.sharedInstance.accessToken)"
        ]

        let parameters = ["movieId": movie.id]
        AF.request(Urls.FAVORITE_URL, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseData { response in

            SVProgressHUD.dismiss()

            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }

            if response.response?.statusCode == 200 || response.response?.statusCode == 201  {
                //let json = JSON(response.data!)
                self.movie.favorite.toggle()
                self.setupViews()

            } else {
                var ErrorString = "CONNECTION_ERROR".localized()
                if let sCode = response.response?.statusCode {
                    ErrorString = ErrorString + " \(sCode)"
                }
                ErrorString = ErrorString + " \(resultString)"
                SVProgressHUD.showError(withStatus: "\(ErrorString)")
            }
        }
    }
    
    func setData() {
        posterImageView.sd_setImage(with: URL(string: movie.poster_link))
        titleLabel.text = movie.name
        yearLabel.text = "\(movie.year)"

        for item in movie.genres {
            yearLabel.text = yearLabel.text! + " • " + item.name
        }

        directorValueLabel.text = movie.director
        producerValueLabel.text = movie.producer

        seasonSeriesButton.setTitle("\(movie.seasonCount) сезон" + ", " + "\(movie.seriesCount) серия,", for: .normal)

        descriptionLabel.text = movie.description
    }

    func downloadSimilar() {
        SVProgressHUD.setContainerView(self.view)
        SVProgressHUD.show()

        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        AF.request(Urls.SIMILAR_MOVIES + String(movie.id), method: .get, headers: headers).responseData { response in

            SVProgressHUD.dismiss()

            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }

            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)

                if let array = json.array {
                    for item in array {
                        let movie = Movie(json: item)
                        self.similarMovies.append(movie)
                    }
                    self.sameContentCollectionView.reloadData()
                } else {
                    SVProgressHUD.showError(withStatus: "CONNECTION_ERROR".localized())
                }
            } else {
                var ErrorString = "CONNECTION_ERROR".localized()
                if let sCode = response.response?.statusCode {
                    ErrorString = ErrorString + " \(sCode)"
                }
                ErrorString = ErrorString + " \(resultString)"
                SVProgressHUD.showError(withStatus: "\(ErrorString)")
            }

        }
    }
    
    
    
    
}


extension MovieInfoViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == screenshotsCollectionView {
            return movie.screenshots.count
        }
        return similarMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == screenshotsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScreenshotCell", for: indexPath) as! ScreenshotCollectionViewCell
            
            cell.setData(name: movie.screenshots[indexPath.item].name, link: movie.screenshots[indexPath.item].link)
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SameContentCell", for: indexPath) as! SameContentCollectionViewCell
        cell.setData(movie: similarMovies[indexPath.item])
    
        return cell
    }
}
