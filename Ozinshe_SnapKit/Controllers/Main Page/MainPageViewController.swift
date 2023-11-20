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
        tv.separatorStyle = .none
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        addNavBarImage()
        setupViews()
        setupConstraints()
        downloadMainMovies()
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
           // self.downloadGenres()
        }
    }
}



extension MainPageViewController {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 292
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
