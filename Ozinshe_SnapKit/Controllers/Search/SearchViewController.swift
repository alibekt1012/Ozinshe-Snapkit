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

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)

        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }

            layoutAttribute.frame.origin.x = leftMargin

            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY , maxY)
        }

        return attributes
    }
}

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
   
    var movies: [Movie] = []
    
    var categories: [Category] = []
    
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
        button.addTarget(self, action: #selector(searhcButtonTouched), for: .touchUpInside)
        return button
    }()
    
    private lazy var clearButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "clear"), for: .normal)
        button.imageView?.contentMode = .scaleToFill
        button.addTarget(self, action: #selector(clearSearch), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Санаттар"
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
    
    private lazy var categoryCollectionView: UICollectionView = {
        
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16.0, left: 24.0, bottom: 16.0, right: 24.0)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 8
        layout.estimatedItemSize.width = 100

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
         cv.delegate = self
         cv.dataSource = self
         cv.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "CategoryCell")
       
        
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Search"
        
        setupViews()
        setupConstraints()
        keyboardWhenTappedAround()
        downloadCategories()
    }
    
    func setupViews() {
        view.addSubviews(searchTextField, searchButton, clearButton, titleLabel, searchResultsTableView, categoryCollectionView)
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
        
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(400)
            make.bottom.equalTo(searchResultsTableView.snp.top)
        }
        searchResultsTableView.snp.makeConstraints { make in
            make.top.equalTo(categoryCollectionView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
       
    }
    
    func keyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
    
    @objc func searhcButtonTouched() {
        downloadSearchMovies()
    }
    
    // MARK: - Download caregories
    func downloadCategories() {
        
        SVProgressHUD.setContainerView(self.view)
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        
        AF.request(Urls.CATEGORIES_URL, method: .get, headers: headers).responseData { response in
                   
                   SVProgressHUD.dismiss()
                   var resultString = ""
                   if let data = response.data {
                       resultString = String(data: data, encoding: .utf8)!
                       print(resultString)
                   }
                   
                   if response.response?.statusCode == 200 {
                       let json = JSON(response.data!)
                       print("JSON: \(json)")
                       
                       if let array = json.array {
                           for item in array {
                               let category = Category(json: item)
                               self.categories.append(category)
                           }
                           self.categoryCollectionView.reloadData()
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
    
    func downloadSearchMovies() {
        
        let searchText = searchTextField.text!
        
        if searchText.isEmpty {
            // Hide Table view
            
            searchResultsTableView.snp.removeConstraints()
            searchResultsTableView.snp.makeConstraints { make in
                make.top.equalTo(categoryCollectionView.snp.bottom)
                make.leading.trailing.equalToSuperview()
                make.bottom.equalTo(view.safeAreaLayoutGuide)
            }

            movies.removeAll()
            searchResultsTableView.reloadData()

            titleLabel.text = "Санаттар"

            clearButton.isHidden = true

            return
        }
        
        // Hide collection view and show table view
        
        searchResultsTableView.snp.removeConstraints()
        searchResultsTableView.snp.updateConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
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
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCollectionViewCell
        cell.setupCell(category: categories[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let categoryMoviesVC = CategoryTableViewController()
        
        categoryMoviesVC.categoryId = categories[indexPath.row].id
        categoryMoviesVC.categoryName = categories[indexPath.row].name
        
        navigationController?.pushViewController(categoryMoviesVC, animated: true)
    }
    
    
}
