//
//  FavoritesViewController.swift
//  Ozinshe_SnapKit
//
//  Created by Almat Alibekov on 06.11.2023.
//

import UIKit
import SVProgressHUD
import Alamofire
import SwiftyJSON
import SnapKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var favorites: [Movie] = []
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.dataSource = self
        tv.delegate = self
        tv.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieCell")
        tv.separatorStyle = .none
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        downloadData()
    }
    
    func downloadData() {
        SVProgressHUD.show()
        
        self.favorites.removeAll()
        
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        AF.request(Urls.FAVORITE_URL, method: .get, headers: headers).responseData { response in
            
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
                        self.favorites.append(movie)
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                  
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
        tableView.reloadData()
    }
    
    
    
    func setupViews() {
        navigationItem.title = "Favorites"
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell

        cell.setupData(movie: favorites[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 153
    }
    
}
