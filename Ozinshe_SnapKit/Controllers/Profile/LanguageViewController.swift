//
//  LanguageViewController.swift
//  Ozinshe_SnapKit
//
//  Created by Almat Alibekov on 07.11.2023.
//

import UIKit
import SnapKit
import Localize_Swift

protocol LanguageProtocol {
    func languageDidChange()
}

class LanguageViewController: UIViewController, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource{
    
    var delegate: LanguageProtocol?
    
    let languageArray = [["English", "en"], ["Қазақша","kk"], ["Русский", "ru"]]
    
    private lazy var backgroundView: UIView = {
       let view = UIView()
        view.backgroundColor = .white

        let lineView = UIView()
        lineView.backgroundColor = UIColor(red: 0.82, green: 0.84, blue: 0.86, alpha: 1)
        lineView.layer.cornerRadius = 2.5
        
        let languageLabel = UILabel()
        languageLabel.text = "LANGUAGE".localized()
        languageLabel.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        languageLabel.textColor = UIColor(red: 0.07, green: 0.09, blue: 0.15, alpha: 1)
       
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LanguageTableViewCell.self, forCellReuseIdentifier: "LanguageCell")
        tableView.separatorStyle = .none

        view.addSubview(lineView)
        view.addSubview(languageLabel)
        view.addSubview(tableView)
        
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(21)
            make.centerX.equalToSuperview()
            make.width.equalTo(64)
            make.height.equalTo(5)
        }
        
        languageLabel.snp.makeConstraints { make in
            make.leading.equalTo(24)
            make.top.equalTo(lineView.snp.bottom).offset(24)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(languageLabel.snp.bottom).offset(12)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        func configureLanguage() {
            
        }
        
       return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        self.navigationController?.isNavigationBarHidden = true
        
        backgroundView.layer.cornerRadius = 32
        backgroundView.clipsToBounds = true
        backgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        tap.delegate = self
        view.addGestureRecognizer(tap)
        
        setupViews()
        setupConstraints()

    }
    
    // Setup Views
    
    func setupViews() {
        view.addSubview(backgroundView)
    }
    // Setup constraints
    func setupConstraints() {
        
        backgroundView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(303)
        }
        
    }
    
    // Dismiss view
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: backgroundView))! {
            return false
        }
        return true
    }
    
    @objc func dismissView() {
        dismiss(animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languageArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell", for: indexPath) as! LanguageTableViewCell
        
        var imageString = ""
        
        if Localize.currentLanguage() == languageArray[indexPath.row][1] {
            imageString = "Check"
        } else {
            imageString = ""
        }
        
        cell.setupData(language: languageArray[indexPath.row][0], image: imageString)
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Localize.setCurrentLanguage(languageArray[indexPath.row][1])
        delegate?.languageDidChange()
        dismissView()
    }

}
