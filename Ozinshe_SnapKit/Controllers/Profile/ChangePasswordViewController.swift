//
//  ChangePasswordViewController.swift
//  Ozinshe_SnapKit
//
//  Created by Almat Alibekov on 09.11.2023.
//

import UIKit
import SnapKit
import SVProgressHUD
import Alamofire
import SwiftyJSON

class ChangePasswordViewController: UIViewController {

    // - MARK: UI Elements
    
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(red: 0.07, green: 0.09, blue: 0.15, alpha: 1)
        return label
    }()
    
    private lazy var passwordTextField: TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        textField.borderStyle = .none
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        textField.placeholder = "Сіздің құпия сөзіңіз"
        textField.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        textField.textColor = UIColor(red: 0.07, green: 0.09, blue: 0.15, alpha: 1)
        textField.textContentType = .password
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var repeatPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Repeat password"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(red: 0.07, green: 0.09, blue: 0.15, alpha: 1)
        return label
    }()
    
    private lazy var repeatPasswordTextField: TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        textField.borderStyle = .none
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        textField.placeholder = "Құпия сөзді қайталаңыз"
        textField.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        textField.textColor = UIColor(red: 0.07, green: 0.09, blue: 0.15, alpha: 1)
        textField.textContentType = .password
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var keyIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "keyIcon")
        return image
    }()
    
    private lazy var showPasswordButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "showIcon"), for: .normal)
        button.addTarget(self, action: #selector(showPassword), for: .touchUpInside)
        return button
    }()
    
    private lazy var keyIcon2: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "keyIcon")
        return image
    }()
    
    private lazy var showPasswordButton2: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "showIcon"), for: .normal)
        button.addTarget(self, action: #selector(showPassword), for: .touchUpInside)
        return button
    }()
    
    private lazy var saveChangesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Өзгерістерді сақтау", for: .normal)
        button.backgroundColor = UIColor(red: 0.5, green: 0.18, blue: 0.99, alpha: 1)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.addTarget(self, action: #selector(saveChanges), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Құпия сөзді өзгерту"
        setupViews()
        setupConstraints()
        
    }
    
    
    // - MARK: Setup views
    func setupViews() {
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(keyIcon)
        view.addSubview(showPasswordButton)
        view.addSubview(repeatPasswordLabel)
        view.addSubview(repeatPasswordTextField)
        view.addSubview(keyIcon2)
        view.addSubview(showPasswordButton2)
        view.addSubview(saveChangesButton)
        
    }
    
    // - MARK: Setup constrains
    func setupConstraints() {
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(21)
            make.leading.equalTo(24)
            
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(4)
            make.leading.equalTo(24)
            make.trailing.equalTo(-24)
            make.height.equalTo(56)
        }
        
        keyIcon.snp.makeConstraints { make in
            make.leading.equalTo(passwordTextField.snp.leading).offset(16)
            make.height.width.equalTo(20)
            make.centerY.equalTo(passwordTextField.snp.centerY)
        }
        showPasswordButton.snp.makeConstraints { make in
            make.trailing.equalTo(passwordTextField.snp.trailing)
            make.top.equalTo(passwordTextField.snp.top)
            make.bottom.equalTo(passwordTextField.snp.bottom)
            make.width.equalTo(52)
        }
        
        repeatPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(24)
            make.leading.equalTo(24)
        }
        
        repeatPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(repeatPasswordLabel.snp.bottom).offset(4)
            make.leading.equalTo(24)
            make.trailing.equalTo(-24)
            make.height.equalTo(56)
        }
        
        keyIcon2.snp.makeConstraints { make in
            make.leading.equalTo(repeatPasswordTextField.snp.leading).offset(16)
            make.height.width.equalTo(20)
            make.centerY.equalTo(repeatPasswordTextField.snp.centerY)
        }
        showPasswordButton2.snp.makeConstraints { make in
            make.trailing.equalTo(repeatPasswordTextField.snp.trailing)
            make.top.equalTo(repeatPasswordTextField.snp.top)
            make.bottom.equalTo(repeatPasswordTextField.snp.bottom)
            make.width.equalTo(52)
        }
        
        saveChangesButton.snp.makeConstraints { make in
            make.leading.equalTo(24)
            make.height.equalTo(56)
            make.trailing.equalTo(-24)
            make.bottom.equalTo(-42)
        }
    }
    
    @objc func showPassword(_ sender: UIButton) {
        if sender == showPasswordButton {
            passwordTextField.isSecureTextEntry.toggle()
        } else if sender == showPasswordButton2 {
            repeatPasswordTextField.isSecureTextEntry.toggle()
        }
    }
    
    @objc func saveChanges() {
        SVProgressHUD.setContainerView(self.view)
        SVProgressHUD.show()
        
        let password = passwordTextField.text!
        let confirmPassword = repeatPasswordTextField.text!
        
        let parameters = ["password" : password]
                
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        
        if password != confirmPassword {
            SVProgressHUD.dismiss()
            SVProgressHUD.showError(withStatus: "Password's is not matching")
            return
        }
        
        AF.request("http://api.ozinshe.com/core/V1/user/profile/changePassword", method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseData { response in
            
            SVProgressHUD.dismiss()
            
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
            }
            
            if response.response?.statusCode == 200 {
                SVProgressHUD.showSuccess(withStatus: "Password changed")
                SVProgressHUD.dismiss(withDelay: 1.5)
            } else {
                var ErrorString = "CONNECTION_ERROR".localized()
                if let sCode = response.response?.statusCode {
                    ErrorString = ErrorString + " \(sCode)"
                }
                ErrorString = ErrorString + " \(resultString)"
                SVProgressHUD.showError(withStatus: "\(ErrorString)")
                SVProgressHUD.dismiss(withDelay: 1.5)
            }
        }
        
    }
    
}
