//
//  SearchViewController.swift
//  Ozinshe_SnapKit
//
//  Created by Almat Alibekov on 06.11.2023.
//

import UIKit
import SnapKit
import SVProgressHUD
import Alamofire
import SwiftyJSON

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var movies: [Movie] = []
    
    private lazy var searchTextField: TextFieldWithPadding = {
       let search = TextFieldWithPadding()
        search.borderStyle = .none
        search.padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        search.layer.borderWidth = 1
        search.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        search.layer.cornerRadius = 12
        search.addTarget(self, action: #selector(searchValueChanged), for: .editingChanged)
        search.addTarget(self, action: #selector(textFieldEditingDidBegin), for: .editingDidBegin)
        search.addTarget(self, action: #selector(textFieldEditingDidEnd), for: .editingDidEnd)
        return search
    }()
    
    private lazy var searchButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "searchButton"), for: .normal)
        button.imageView?.contentMode = .scaleToFill
        button.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.96, alpha: 1)
        button.layer.cornerRadius = 12
        return button
    }()
    
    private lazy var clearButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "clear"), for: .normal)
        button.imageView?.contentMode = .scaleToFill
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Іздеу нәтижелері"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(red: 0.07, green: 0.09, blue: 0.15, alpha: 1)
        return label
        
    }()
    
    private lazy var searchResultsTableView: UITableView = {
       
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieCell")
        return tv
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Search"
        
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        view.addSubviews(searchTextField, searchButton, clearButton, titleLabel, searchResultsTableView)
    }
    
    func setupConstraints() {
        searchTextField.snp.makeConstraints { make in
            make.leading.equalTo(24)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.width.equalTo(254)
            make.height.equalTo(56)
        }
        searchButton.snp.makeConstraints { make in
            make.leading.equalTo(searchTextField.snp.trailing).offset(16)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.trailing.equalTo(-24)
            make.height.equalTo(56)
        }
        clearButton.snp.makeConstraints { make in
            make.trailing.equalTo(searchTextField.snp.trailing)
            make.top.equalTo(searchTextField.snp.top)
            make.bottom.equalTo(searchTextField.snp.bottom)
            make.width.equalTo(52)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(24)
            make.top.equalTo(searchTextField.snp.bottom).offset(32)
        }
        searchResultsTableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    
    @objc func textFieldEditingDidBegin(_ textField: UITextField) {
          if let customTextField = textField as? TextFieldWithPadding {
              customTextField.layer.borderColor = UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1.00).cgColor
          }
      }

      @objc func textFieldEditingDidEnd(_ textField: UITextField) {
          if let customTextField = textField as? TextFieldWithPadding {
              customTextField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
          }
      }
    
    
    @objc func searchValueChanged() {
        downloadSearchMovies()
    }
    
    @objc func clearSearch(_ sender: Any) {
        searchTextField.text = ""
        searchValueChanged()
    }
    
    
    func downloadSearchMovies() {
        
        let searchText = searchTextField.text!
        
        if searchText.isEmpty {
            // Hide tableView
//            tableViewToLableConstraint.priority = .defaultLow
//            tableViewToCollectionViewConstraint.priority = .defaultHigh

            movies.removeAll()
            searchResultsTableView.reloadData()

            titleLabel.text = "Санаттар"

            clearButton.isHidden = true

            return
        }
        
//         Показать tableview
//
//        tableViewToLableConstraint.priority = .defaultHigh
//        tableViewToCollectionViewConstraint.priority = .defaultLow
        titleLabel.text = "Іздеу нәтижелері"
        clearButton.isHidden = false
        
        SVProgressHUD.setContainerView(self.view)
       
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        
        let parameters = ["search": searchTextField.text!]
        
        AF.request(Urls.SEARCH_MOVIES_URL, method: .get, parameters: parameters, headers: headers).responseData { response in
            
            SVProgressHUD.dismiss()
            
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                
                if let array = json.array {
                    self.movies.removeAll()
                    self.searchResultsTableView.reloadData()
                    for item in array {
                        let movie = Movie(json: item)
                        self.movies.append(movie)
                    }
                    self.searchResultsTableView.reloadData()
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
    }}




extension SearchViewController {
    
    // Table view results
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieTableViewCell
        cell.setupData(movie: movies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 153
    }
}
