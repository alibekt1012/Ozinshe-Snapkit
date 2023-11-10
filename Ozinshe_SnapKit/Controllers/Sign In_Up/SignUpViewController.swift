//
//  SignUpViewController.swift
//  Ozinshe_SnapKit
//
//  Created by Almat Alibekov on 09.11.2023.
//

import UIKit
import SnapKit
import Alamofire
import SVProgressHUD
import SDWebImage
import SwiftyJSON
import Localize_Swift

class SignUpViewController: UIViewController {
    
    var validation = Validation()
    
    // - MARK: UI
    private lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Тіркелу"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(red: 0.07, green: 0.09, blue: 0.15, alpha: 1)
        return label
    }()
    
    private lazy var fillLabel: UILabel = {
        let label = UILabel()
        label.text = "Деректерді толтырыңыз"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        label.textColor = UIColor(red: 0.42, green: 0.45, blue: 0.5, alpha: 1)
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(red: 0.07, green: 0.09, blue: 0.15, alpha: 1)
        return label
    }()
    
    private lazy var emailTextField: TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        textField.borderStyle = .none
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        textField.placeholder = "Сіздің email"
        textField.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        textField.textColor = UIColor(red: 0.07, green: 0.09, blue: 0.15, alpha: 1)
        //textField.addTarget(self, action: #selector(textFieldEditingDidBegin), for: .editingDidBegin)
        //textField.addTarget(self, action: #selector(textFieldEditingDidEnd), for: .editingDidEnd)
        return textField
    }()
    
    private lazy var mailIconImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "mailIcon")
        return image
    }()
    
    
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Құпия сөз"
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
        textField.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        textField.textColor = UIColor(red: 0.07, green: 0.09, blue: 0.15, alpha: 1)
        textField.textContentType = .password
        textField.isSecureTextEntry = true
        textField.addTarget(self, action: #selector(textFieldEditingDidBegin), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(textFieldEditingDidEnd), for: .editingDidEnd)
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
    
    private lazy var repeatPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Құпия сөзді қайталаңыз"
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
        textField.placeholder = "Сіздің құпия сөзіңіз"
        textField.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        textField.textColor = UIColor(red: 0.07, green: 0.09, blue: 0.15, alpha: 1)
        textField.textContentType = .password
        textField.isSecureTextEntry = true
        textField.addTarget(self, action: #selector(textFieldEditingDidBegin), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(textFieldEditingDidEnd), for: .editingDidEnd)
        return textField
    }()
    
    private lazy var repeatKeyIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "keyIcon")
        return image
    }()
    
    private lazy var repeatShowPasswordButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "showIcon"), for: .normal)
        button.addTarget(self, action: #selector(showPassword), for: .touchUpInside)
        return button
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Тіркелу", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.backgroundColor = UIColor(red: 0.5, green: 0.18, blue: 0.99, alpha: 1)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        return button
    }()
    
    private lazy var validationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(red: 1, green: 0.25, blue: 0.17, alpha: 1)
        return label
    }()
    
    // - MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        
    }
    // - MARK: Views
    func setupViews() {
        view.addSubviews(signUpLabel, fillLabel, emailLabel, emailTextField, mailIconImageView, passwordLabel, passwordTextField, keyIcon, showPasswordButton, repeatPasswordLabel, repeatPasswordTextField, repeatKeyIcon, repeatShowPasswordButton, signUpButton, validationLabel)
    }
    // - MARK: Constraints
    func setupConstraints() {
        signUpLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalTo(24)
        }
        fillLabel.snp.makeConstraints { make in
            make.top.equalTo(signUpLabel.snp.bottom).offset(4)
            make.leading.equalTo(24)
        }
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(fillLabel.snp.bottom).offset(32)
            make.leading.equalTo(24)
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(4)
            make.leading.equalTo(24)
            make.trailing.equalTo(-24)
            make.height.equalTo(56)
        }
        mailIconImageView.snp.makeConstraints { make in
            make.leading.equalTo(emailTextField.snp.leading).offset(16)
            make.height.width.equalTo(20)
            make.centerY.equalTo(emailTextField.snp.centerY)
        }
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(13)
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
            make.top.equalTo(passwordTextField.snp.bottom).offset(13)
            make.leading.equalTo(24)
        }
        repeatPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(repeatPasswordLabel.snp.bottom).offset(4)
            make.leading.equalTo(24)
            make.trailing.equalTo(-24)
            make.height.equalTo(56)
        }
        
        repeatKeyIcon.snp.makeConstraints { make in
            make.leading.equalTo(repeatPasswordTextField.snp.leading).offset(16)
            make.height.width.equalTo(20)
            make.centerY.equalTo(repeatPasswordTextField.snp.centerY)
        }
        repeatShowPasswordButton.snp.makeConstraints { make in
            make.trailing.equalTo(repeatPasswordTextField.snp.trailing)
            make.top.equalTo(repeatPasswordTextField.snp.top)
            make.bottom.equalTo(repeatPasswordTextField.snp.bottom)
            make.width.equalTo(52)
        }
        
        if validationLabel.text == nil {
            signUpButton.snp.makeConstraints { make in
                make.top.equalTo(repeatPasswordTextField.snp.bottom).offset(40)
                make.leading.equalTo(24)
                make.trailing.equalTo(-24)
                make.height.equalTo(56)
            }
        } else {
            validationLabel.snp.makeConstraints { make in
                make.top.equalTo(repeatPasswordTextField.snp.bottom).offset(32)
                make.leading.equalTo(24)
                make.trailing.equalTo(-24)
            }
            signUpButton.snp.makeConstraints { make in
                make.top.equalTo(validationLabel.snp.bottom).offset(40)
                make.leading.equalTo(24)
                make.trailing.equalTo(-24)
                make.height.equalTo(56)
            }
        }
        
    }
    
    // - MARK: Logic
    
    @objc func signUp() {
        SVProgressHUD.show()
        
        let email = emailTextField.text!
        let password = passwordTextField.text!
        let repeatedPassword = repeatPasswordTextField.text!
        let isValidateEmail = self.validation.validateEmailId(emailID: email)
        
        if email.isEmpty || password.isEmpty {
            SVProgressHUD.dismiss()
            validationLabel.text = "Please fill all required fields"
            signUpButton.snp.removeConstraints()
            setupConstraints()
            return
        }
       
        if isValidateEmail == false {
            SVProgressHUD.dismiss()
            emailTextField.layer.borderColor = UIColor(red: 1.00, green: 0.25, blue: 0.17, alpha: 1.00).cgColor
            validationLabel.text = "Қате формат"
            signUpButton.snp.removeConstraints()
            setupConstraints()
            return
        }
        
        if password != repeatedPassword {
            SVProgressHUD.dismiss()
            passwordTextField.layer.borderColor = UIColor(red: 1.00, green: 0.25, blue: 0.17, alpha: 1.00).cgColor
            repeatPasswordTextField.layer.borderColor = UIColor(red: 1.00, green: 0.25, blue: 0.17, alpha: 1.00).cgColor
            validationLabel.text = "Пароли не совпадают"
            signUpButton.snp.removeConstraints()
            setupConstraints()
            return
        }
        
        
        let parameters = ["email": email, "password": password]
        
        AF.request(Urls.SIGN_UP_URL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseData { response in
            SVProgressHUD.dismiss()
            
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                
                if let accessToken = json["accessToken"].string {
                    UserDefaults.standard.set(accessToken,forKey: "accessToken")
                    
                    Storage.sharedInstance.accessToken = accessToken
                    
                    self.startApp()
                } else {
                    SVProgressHUD.showError(withStatus: "error")
                }
            } else {
                var errorString = "error"
                if let sCode = response.response?.statusCode {
                    errorString = errorString + "\(sCode)"
                }
                errorString = errorString + "\(resultString)"
                SVProgressHUD.showError(withStatus: "\(errorString)")
            }
        }
        
    }
    
    
    @objc func showPassword(_ sender: UIButton) {
        if sender == showPasswordButton {
            passwordTextField.isSecureTextEntry.toggle()
        } else if sender == repeatShowPasswordButton {
            repeatPasswordTextField.isSecureTextEntry.toggle()
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
    
    func startApp() {
        let tabBarVC = TabBarController()
        tabBarVC.modalPresentationStyle = .fullScreen
        present(tabBarVC, animated: true)
    }
    
}
