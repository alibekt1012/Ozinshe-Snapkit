//
//  PersonalDataViewController.swift
//  Ozinshe_SnapKit
//
//  Created by Almat Alibekov on 06.11.2023.
//

import UIKit
import SnapKit

class PersonalDataViewController: UIViewController {

    
    // Name
    private lazy var nameLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Сіздің атыңыз"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1)
        return label
        
    }()
    
    private lazy var nameTextField: UITextField  = {
       
        let textField = UITextField()
        textField.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        textField.textColor = UIColor(red: 0.07, green: 0.09, blue: 0.15, alpha: 1)
        textField.placeholder = "Сіздің атыңыз..."
        return textField
        
    }()
    
    private lazy var separatorView: UIView = {
        
       let view = UIView()
       view.backgroundColor = UIColor(red: 0.82, green: 0.84, blue: 0.86, alpha: 1)
       return view
        
    }()
    
    // Email
    private lazy var emailLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Email"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1)
        return label
        
    }()
    
    private lazy var emailTextField: UITextField  = {
       
        let textField = UITextField()
        textField.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        textField.textColor = UIColor(red: 0.07, green: 0.09, blue: 0.15, alpha: 1)
        textField.placeholder = "Email..."
        return textField
        
    }()
    
    private lazy var separatorView2: UIView = {
        
       let view = UIView()
       view.backgroundColor = UIColor(red: 0.82, green: 0.84, blue: 0.86, alpha: 1)
       return view
        
    }()
    
    // Phone
    private lazy var phoneLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Телефон"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1)
        return label
        
    }()
    
    private lazy var phoneTextField: UITextField  = {
       
        let textField = UITextField()
        textField.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        textField.textColor = UIColor(red: 0.07, green: 0.09, blue: 0.15, alpha: 1)
        textField.placeholder = "Телефон..."
        return textField
        
    }()
    
    private lazy var separatorView3: UIView = {
        
       let view = UIView()
       view.backgroundColor = UIColor(red: 0.82, green: 0.84, blue: 0.86, alpha: 1)
       return view
        
    }()
    
    // Birthdate
    private lazy var birthdayLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Туылған күні"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1)
        return label
        
    }()
    
    private lazy var birthdayTextField: UITextField  = {
       
        let textField = UITextField()
        textField.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        textField.textColor = UIColor(red: 0.07, green: 0.09, blue: 0.15, alpha: 1)
        textField.placeholder = "Туылған күні..."
        return textField
        
    }()
    
    private lazy var separatorView4: UIView = {
        
       let view = UIView()
       view.backgroundColor = UIColor(red: 0.82, green: 0.84, blue: 0.86, alpha: 1)
       return view
        
    }()
    
    // Save button
    private lazy var saveButton: UIButton = {
       
        let button = UIButton()
        button.setTitle("Өзгерістерді сақтау", for: .normal)
        button.backgroundColor = UIColor(red: 0.5, green: 0.18, blue: 0.99, alpha: 1)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 12
        return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        navigationItem.title = " Жеке деректер"
        
        setupViews()
        setupConstraints()
        
    }
    
    

    func setupViews() {
        
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(separatorView)
        
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(separatorView2)
        
        view.addSubview(phoneLabel)
        view.addSubview(phoneTextField)
        view.addSubview(separatorView3)
        
        view.addSubview(birthdayLabel)
        view.addSubview(birthdayTextField)
        view.addSubview(separatorView4)
        
        view.addSubview(saveButton)
    }
    
    func setupConstraints() {
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(24)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
        }
        nameTextField.snp.makeConstraints { make in
            make.leading.equalTo(24)
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.trailing.equalTo(-24)
        }
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(89)
            make.leading.equalTo(24)
            make.trailing.equalTo(-24)
            make.height.equalTo(1)
        }
        
        
        emailLabel.snp.makeConstraints { make in
            make.leading.equalTo(24)
            make.top.equalTo(separatorView.snp.bottom).offset(24)
        }
        emailTextField.snp.makeConstraints { make in
            make.leading.equalTo(24)
            make.top.equalTo(emailLabel.snp.bottom).offset(8)
            make.trailing.equalTo(-24)
        }
        separatorView2.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom).offset(89)
            make.leading.equalTo(24)
            make.trailing.equalTo(-24)
            make.height.equalTo(1)
        }
        
        
        phoneLabel.snp.makeConstraints { make in
            make.leading.equalTo(24)
            make.top.equalTo(separatorView2.snp.bottom).offset(24)
        }
        
        phoneTextField.snp.makeConstraints { make in
            make.leading.equalTo(24)
            make.top.equalTo(phoneLabel.snp.bottom).offset(8)
            make.trailing.equalTo(-24)
        }
        separatorView3.snp.makeConstraints { make in
            make.top.equalTo(separatorView2.snp.bottom).offset(89)
            make.leading.equalTo(24)
            make.trailing.equalTo(-24)
            make.height.equalTo(1)
        }
        
        
        birthdayLabel.snp.makeConstraints { make in
            make.leading.equalTo(24)
            make.top.equalTo(separatorView3.snp.bottom).offset(24)
        }
        
        birthdayTextField.snp.makeConstraints { make in
            make.leading.equalTo(24)
            make.top.equalTo(birthdayLabel.snp.bottom).offset(8)
            make.trailing.equalTo(-24)
        }
        separatorView4.snp.makeConstraints { make in
            make.top.equalTo(separatorView3.snp.bottom).offset(89)
            make.leading.equalTo(24)
            make.trailing.equalTo(-24)
            make.height.equalTo(1)
        }
        
        saveButton.snp.makeConstraints { make in
            make.leading.equalTo(24)
            make.trailing.equalTo(-24)
            make.top.equalTo(separatorView4.snp.bottom).offset(250)
            make.height.equalTo(56)
        }
    }

} 
