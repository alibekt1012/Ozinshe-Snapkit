//
//  ProfileViewController.swift
//  Ozinshe_SnapKit
//
//  Created by Almat Alibekov on 06.11.2023.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController, LanguageProtocol {
    func languageDidChange() {
        
    }
    
    
    private lazy var avatarImage: UIImageView = {
        
        let image = UIImageView()
        image.image = UIImage(named: "Avatar")
        image.contentMode = .scaleAspectFill
        return image
        
    }()
    
    private lazy var myProfileLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Менің профилім"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(red: 0.07, green: 0.09, blue: 0.15, alpha: 1.00)
        return label
        
    }()
    
    private lazy var emailLabel: UILabel = {
        
        let label = UILabel()
        label.text = "qwerty@mail.ru"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1)
        return label
        
    }()
    
    private lazy var profileOptionsView: UIView = {
       
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)
        
        // Personal data
        var personalDataButton = UIButton()
        personalDataButton.setTitle("Жеке деректер", for: .normal)
        personalDataButton.setTitleColor(UIColor(red: 0.11, green: 0.14, blue: 0.19, alpha: 1), for: .normal)
        personalDataButton.titleLabel?.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        personalDataButton.contentHorizontalAlignment = .left
        personalDataButton.addTarget(self, action: #selector(personalDataButtonTouched), for: .touchUpInside)
    
        var editLabel = UILabel()
        editLabel.text = "Өңдеу"
        editLabel.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        editLabel.textColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1)
        
        var arrow = UIImageView()
        arrow.image = UIImage(named: "arrow")
        arrow.contentMode = .scaleAspectFill
        
        var separatorView = UIView()
        separatorView.backgroundColor = UIColor(red: 0.82, green: 0.84, blue: 0.86, alpha: 1)
        
        
        // Change password
        var changePasswordButton = UIButton()
        changePasswordButton.setTitle("Құпия сөзді өзгерту", for: .normal)
        changePasswordButton.setTitleColor(UIColor(red: 0.11, green: 0.14, blue: 0.19, alpha: 1), for: .normal)
        changePasswordButton.titleLabel?.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        changePasswordButton.contentHorizontalAlignment = .left
            
        var arrow2 = UIImageView()
        arrow2.image = UIImage(named: "arrow")
        arrow2.contentMode = .scaleAspectFill
        
        var separatorView2 = UIView()
        separatorView2.backgroundColor = UIColor(red: 0.82, green: 0.84, blue: 0.86, alpha: 1)
        
        // Language
        var languageButton = UIButton()
        languageButton.setTitle("Тіл", for: .normal)
        languageButton.setTitleColor(UIColor(red: 0.11, green: 0.14, blue: 0.19, alpha: 1), for: .normal)
        languageButton.titleLabel?.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        languageButton.contentHorizontalAlignment = .left
        languageButton.addTarget(self, action: #selector(changeLanguageButtonTouched), for: .touchUpInside)
        
        var languageLabel = UILabel()
        languageLabel.text = "Қазақша"
        languageLabel.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        languageLabel.textColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1)
        
        var arrow3 = UIImageView()
        arrow3.image = UIImage(named: "arrow")
        arrow3.contentMode = .scaleAspectFill
        
        var separatorView3 = UIView()
        separatorView3.backgroundColor = UIColor(red: 0.82, green: 0.84, blue: 0.86, alpha: 1)
        
        // Dark theme
        var darkThemeLabel = UILabel()
        darkThemeLabel.text = "Қараңғы режим"
        darkThemeLabel.textColor = UIColor(red: 0.11, green: 0.14, blue: 0.19, alpha: 1)
        darkThemeLabel.font = UIFont(name: "SFProDisplay-Medium", size: 16)
      
        var darkThemeSwitch = UISwitch()
        darkThemeSwitch.onTintColor = UIColor(red: 0.7, green: 0.46, blue: 0.97, alpha: 1)        
        
        // Add subviews
        view.addSubviews(personalDataButton, editLabel, arrow, separatorView, changePasswordButton, arrow2, separatorView2, languageButton, arrow3, languageLabel, separatorView3, darkThemeLabel, darkThemeSwitch)
        
        // Personal data block constraints
        personalDataButton.snp.makeConstraints { make in
            make.leading.equalTo(24)
            make.trailing.equalTo(-24)
            make.top.equalToSuperview()
            make.centerY.equalTo(arrow.snp.centerY)
        }
        
        arrow.snp.makeConstraints { make in
            make.top.equalTo(24)
            make.trailing.equalTo(-24)
            make.height.width.equalTo(16)
        }
        
        editLabel.snp.makeConstraints { make in
            make.top.equalTo(24)
            make.trailing.equalTo(arrow.snp.leading).offset(-8)
            make.centerY.equalTo(arrow.snp.centerY)
            
        }
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(personalDataButton.snp.bottom)
            make.leading.equalTo(24)
            make.trailing.equalTo(-24)
            make.height.equalTo(1)
        }
        
        // Change password constraints
        changePasswordButton.snp.makeConstraints { make in
            make.leading.equalTo(24)
            make.trailing.equalTo(-24)
            make.top.equalTo(separatorView.snp.bottom)
            make.centerY.equalTo(arrow2.snp.centerY)
            
        }
        arrow2.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom).offset(24)
            make.trailing.equalTo(-24)
            make.height.width.equalTo(16)
        }
        separatorView2.snp.makeConstraints { make in
            make.top.equalTo(changePasswordButton.snp.bottom)
            make.leading.equalTo(24)
            make.trailing.equalTo(-24)
            make.height.equalTo(1)
        }
        
        // Language constraints
        languageButton.snp.makeConstraints { make in
            make.leading.equalTo(24)
            make.trailing.equalTo(-24)
            make.top.equalTo(separatorView2.snp.bottom)
            make.centerY.equalTo(arrow3.snp.centerY)
        }
        arrow3.snp.makeConstraints { make in
            make.top.equalTo(separatorView2.snp.bottom).offset(24)
            make.trailing.equalTo(-24)
            make.height.width.equalTo(16)
        }
        
        languageLabel.snp.makeConstraints { make in
            make.top.equalTo(separatorView2.snp.bottom).offset(24)
            make.trailing.equalTo(arrow3.snp.leading).offset(-8)
            make.centerY.equalTo(arrow3.snp.centerY)
        }
        separatorView3.snp.makeConstraints { make in
            make.top.equalTo(languageButton.snp.bottom)
            make.leading.equalTo(24)
            make.trailing.equalTo(-24)
            make.height.equalTo(1)
        }
        
        // Dark theme constraints
        darkThemeLabel.snp.makeConstraints { make in
            make.top.equalTo(separatorView3.snp.bottom)
            make.leading.equalTo(24)
            make.centerY.equalTo(darkThemeSwitch.snp.centerY)
        }
        darkThemeSwitch.snp.makeConstraints { make in
            make.top.equalTo(separatorView3.snp.bottom).offset(24)
            make.trailing.equalTo(-24)
            
        }
        return view
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        navigationItem.title = "Профиль"
        setupViews()
        setupConstraints()
    }
    // Setup Views
    func setupViews() {
        view.addSubview(avatarImage)
        view.addSubview(myProfileLabel)
        view.addSubview(emailLabel)
        view.addSubview(profileOptionsView)
    }
    
    // Setup Constarints
    func setupConstraints() {
        avatarImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(32)
            make.height.width.equalTo(104)
            make.centerX.equalToSuperview()
        }
        myProfileLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImage.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(myProfileLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        profileOptionsView.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            
        }
    }
    
    // Localization
    
    
    @objc func personalDataButtonTouched() {
        
        let personalDataVC = PersonalDataViewController()
        personalDataVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(personalDataVC, animated: true)
    }
    
    @objc func changeLanguageButtonTouched() {
        
        let languageVC = LanguageViewController()
        languageVC.hidesBottomBarWhenPushed = true
        languageVC.modalPresentationStyle = .overFullScreen
        present(languageVC, animated: true)
        
    }
    
    
}

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
}
