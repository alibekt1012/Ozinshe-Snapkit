//
//  MainPageViewController.swift
//  Ozinshe_SnapKit
//
//  Created by Almat Alibekov on 06.11.2023.
//

import UIKit
import SnapKit
import SVProgressHUD
import SwiftyJSON
import Alamofire


class MainPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    var mainMovies: [MainMovie] = []
    
    private lazy var tableView: UITableView = {
       let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(MainTableViewCell.self, forCellReuseIdentifier: "MainCell")
        tv.register(MainBannerTableViewCell.self, forCellReuseIdentifier: "MainBannerCell")
        tv.register(HistoryTableViewCell.self, forCellReuseIdentifier: "HistoryCell")
        tv.register(GenreAgeTableViewCell.self, forCellReuseIdentifier: "GenreAgeCell")
        tv.separatorStyle = .none
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        addNavBarImage()
        setupViews()
        setupConstraints()
        downloadMainBanners()
    }
    
    // - MARK: Setup Views
    func setupViews() {
        view.addSubviews(tableView)
    }
    
    
    // - MARK: Setup Constraints
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func addNavBarImage() {
        let image = UIImage(named: "LogoMainPage")!
        
        let logoImageView = UIImageView(image: image)
        let imageItem = UIBarButtonItem.init(customView: logoImageView)
        navigationItem.leftBarButtonItem = imageItem
        
    }
    
    func downloadMainBanners() {
        
        SVProgressHUD.setContainerView(self.view)
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        AF.request(Urls.MAIN_BANNERS_URL, method: .get, headers: headers).responseData { response in
            
            SVProgressHUD.dismiss()
            
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                
                if let array = json.array {
                    
                    var newMainMovie = MainMovie()
                    newMainMovie.cellType = .mainBanner
                    
                    for item in array {
                        let bannerMovie = BannerMovie(json: item)
                        newMainMovie.bannerMovie.append(bannerMovie)
                    }
                    self.mainMovies.append(newMainMovie)
                    self.tableView.reloadData()
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
            self.downloadHistory()
            
        }
    }
    
    func downloadHistory() {
        
        SVProgressHUD.setContainerView(self.view)
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        AF.request(Urls.HISTORY_URL, method: .get, headers: headers).responseData { response in
            
            SVProgressHUD.dismiss()
            
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                
                if let array = json.array {
                    
                    var mainMovie = MainMovie()
                    mainMovie.cellType = .userHistory
                    
                    for item in array {
                        let movie = Movie(json: item)
                        mainMovie.movies.append(movie)
                     
                    }
                    if array.count > 0 {
                        self.mainMovies.append(mainMovie)
                    }

                    self.tableView.reloadData()
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
            
            self.downloadMainMovies()
        }
    }
    
    func downloadMainMovies() {
        SVProgressHUD.setContainerView(self.view)
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        AF.request(Urls.MAIN_MOVIES_URL, method: .get, headers: headers).responseData { response in
            
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
                        let mainMovie = MainMovie(json: item)
                        self.mainMovies.append(mainMovie)
                    }
                    
                    self.tableView.reloadData()
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
            self.downloadGenres()
        }
    }
    
    func downloadGenres() {
        SVProgressHUD.setContainerView(self.view)
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        AF.request(Urls.GENRES_URL, method: .get, headers: headers).responseData { response in
            
            SVProgressHUD.dismiss()
            
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                
                if let array = json.array {
                    var newmainMovie1 = MainMovie()
                    newmainMovie1.categoryName = "Жанрды таңдаңыз"
                    newmainMovie1.cellType = .genre
                    
                    for item in array {
                        let genres = Genre(json: item)
                        newmainMovie1.genres.append(genres)
                    }
                    
                    if self.mainMovies.count > 4 {
                        if self.mainMovies[1].cellType == .userHistory {
                            self.mainMovies.insert(newmainMovie1, at: 4)
                        } else {
                            self.mainMovies.insert(newmainMovie1, at: 3)
                        }
                    } else {
                        self.mainMovies.append(newmainMovie1)
                    }

                    self.tableView.reloadData()
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
            self.downloadCategoryAges()
            
        }
    }
    
    func downloadCategoryAges() {
        SVProgressHUD.setContainerView(self.view)
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        AF.request(Urls.CATEGORY_AGES_URL, method: .get, headers: headers).responseData { response in
            
            SVProgressHUD.dismiss()
            
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                
                if let array = json.array {
                    var newmainMovie1 = MainMovie()
                    newmainMovie1.categoryName = "Жасына сәйкес"
                    newmainMovie1.cellType = .ageCategory
                    
                    for item in array {
                        let genres = CategoryAge(json: item)
                        newmainMovie1.categoryAges.append(genres)
                    }
                    
                    if self.mainMovies.count > 8 {
                        if self.mainMovies[1].cellType == .userHistory {
                            self.mainMovies.insert(newmainMovie1, at: 8)
                        } else {
                            self.mainMovies.insert(newmainMovie1, at: 7)
                        }
                    } else {
                        self.mainMovies.append(newmainMovie1)
                    }

                    self.tableView.reloadData()
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



extension MainPageViewController {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if mainMovies[indexPath.row].cellType == .mainBanner {
            return 272
        }
        if mainMovies[indexPath.row].cellType == .userHistory {
            return 228
        }
        if mainMovies[indexPath.row].cellType == .ageCategory {
            return 184
        }
        if mainMovies[indexPath.row].cellType == .genre {
            return 184
        }
        return 292
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if mainMovies[indexPath.row].cellType == .mainBanner {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainBannerCell") as! MainBannerTableViewCell
            cell.setData(mainMovie: mainMovies[indexPath.row])
            return cell
        }
        
        if mainMovies[indexPath.row].cellType == .userHistory {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell") as! HistoryTableViewCell
            cell.setData(mainMovie: mainMovies[indexPath.row])
            return cell
        }
        
        if mainMovies[indexPath.row].cellType == .genre {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GenreAgeCell") as! GenreAgeTableViewCell
            cell.setData(mainMovie: mainMovies[indexPath.row])
            return cell
        }
        
        if mainMovies[indexPath.row].cellType == .ageCategory {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GenreAgeCell") as! GenreAgeTableViewCell
            cell.setData(mainMovie: mainMovies[indexPath.row])
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell") as! MainTableViewCell
        
        cell.setData(mainMovie: mainMovies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categoryMoviesVC = CategoryTableViewController()
        
        categoryMoviesVC.categoryId = mainMovies[indexPath.row].categoryId
        categoryMoviesVC.categoryName = mainMovies[indexPath.row].categoryName
        
        navigationController?.pushViewController(categoryMoviesVC, animated: true)
    }
    
}
