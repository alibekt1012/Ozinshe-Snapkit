//
//  SeasonSeriesViewController.swift
//  Ozinshe_SnapKit
//
//  Created by Almat Alibekov on 30.11.2023.
//

import UIKit
import SwiftyJSON
import Alamofire
import SVProgressHUD
import SDWebImage

class SeasonSeriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
 
    var movie = Movie()
    var seasons: [Season] = []
    var video_link = ""
    
    var currentSeason = 0
    
    private lazy var seasonsCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 24, left: 24.0, bottom: 8, right: 24.0)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.estimatedItemSize.width = 128
        layout.estimatedItemSize.height = 34
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.register(SeasonCollectionViewCell.self, forCellWithReuseIdentifier: "SeasonCell")
        return cv
    }()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(EpisodeTableViewCell.self, forCellReuseIdentifier: "Cell")
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        downloadSeasons()
    }
    
    func setupViews() {
        view.addSubviews(seasonsCollectionView, tableView)
    }
    
    func setupConstraints() {
        seasonsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(66)
        }
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(seasonsCollectionView.snp.bottom)
        }
    }
    
    func downloadSeasons() {
        SVProgressHUD.setContainerView(self.view)
        SVProgressHUD.show()
        
        self.seasons.removeAll()
        self.tableView.reloadData()
        self.seasonsCollectionView.reloadData()
     
        
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        AF.request(Urls.GET_SEASONS_URL + String(movie.id), method: .get, headers: headers).responseData { response in
            
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
                        let season = Season(json: item)
                        self.seasons.append(season)
                    }
                    self.tableView.reloadData()
                    self.seasonsCollectionView.reloadData()
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

extension SeasonSeriesViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return seasons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeasonCell", for: indexPath) as! SeasonCollectionViewCell
        
        cell.setData(season: seasons[indexPath.row], currentSeason: currentSeason)
        
        return cell
            
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        currentSeason = seasons[indexPath.row].number - 1
        tableView.reloadData()
        collectionView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 241
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if seasons.isEmpty {
            return 0
        }
        return seasons[currentSeason].videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! EpisodeTableViewCell
        
        cell.setData(series: seasons[currentSeason].videos[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MoviePlayerViewController()
        
        vc.video_link = movie.video_link
        navigationController?.show(vc, sender: self)
    }
    
}
