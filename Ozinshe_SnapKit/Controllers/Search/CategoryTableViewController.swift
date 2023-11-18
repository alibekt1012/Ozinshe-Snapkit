//
//  CategoryTableViewController.swift
//  Ozinshe_SnapKit
//
//  Created by Almat Alibekov on 16.11.2023.
//

import UIKit
import SwiftyJSON
import Alamofire
import SVProgressHUD

enum CategoryType {
    case categoryId
    case genreId
    case ageCategoryId
    
    var parameterName: String {
        switch self {
        case .categoryId:
            return "categoryId"
        case .genreId:
            return "genreId"
        case .ageCategoryId:
            return "categoryAgeId"
        }
    }
}

class CategoryTableViewController: UITableViewController {

    var movies: [Movie] = []
    var categoryType: CategoryType = .categoryId
    
    var categoryId = 0
    var categoryName = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieCell")
        tableView.separatorStyle = .none
        downloadMovieByCategoryId()
        self.title = categoryName

    }
    
    func downloadMovieByCategoryId() {
        
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        
       
        
        var parameters: [String: Any] = [:]
                
                switch categoryType {
                case .categoryId:
                    parameters[categoryType.parameterName] = categoryId
                case .genreId:
                    parameters[categoryType.parameterName] = categoryId
                case .ageCategoryId:
                    parameters[categoryType.parameterName] = categoryId
                }
        
        AF.request(Urls.MOVIES_BY_CATEGORY_URL, method: .get, parameters: parameters, headers: headers).responseData { response in
            
            SVProgressHUD.dismiss()
            
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                
                if json["content"].exists() {
                    if let array = json["content"].array {
                        for item in array {
                            let movie = Movie(json: item)
                            self.movies.append(movie)
                        }
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

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell

        // Configure the cell...
        cell.setupData(movie: movies[indexPath.row])

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 152
    }
    
 

}
