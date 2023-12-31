//
//  SignInViewController.swift
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

class SignInViewController: UIViewController {
    
    var validation = Validation()

    // - MARK: UI
    private lazy var greetingsLabel: UILabel = {
       let label = UILabel()
        label.text = "Сәлем"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(red: 0.07, green: 0.09, blue: 0.15, alpha: 1)
        return label
    }()
    
    private lazy var logInLabel: UILabel = {
        let label = UILabel()
        label.text = "Аккаунтқа кіріңіз"
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
        textField.addTarget(self, action: #selector(textFieldEditingDidBegin), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(textFieldEditingDidEnd), for: .editingDidEnd)
        return textField
    }()
    
    private lazy var validationLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(red: 1, green: 0.25, blue: 0.17, alpha: 1)
        return label
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
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Құпия сөзді ұмыттыңыз ба?", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        button.setTitleColor(UIColor(red: 0.7, green: 0.46, blue: 0.97, alpha: 1), for: .normal)
        button.contentHorizontalAlignment = .trailing
        return button
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Кіру", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.backgroundColor = UIColor(red: 0.5, green: 0.18, blue: 0.99, alpha: 1)
        button.layer.cornerRadius = 12
        return button
    }()
    
    private lazy var noAccountView: UIView = {
       let view = UIView()
        
        let noAccountLabel = UILabel()
        noAccountLabel.text = "Аккаунтыныз жоқ па?"
        noAccountLabel.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        noAccountLabel.textColor = UIColor(red: 0.42, green: 0.45, blue: 0.5, alpha: 1)
        
        let registrationButton = UIButton()
        registrationButton.setTitle(" Тіркелу", for: .normal)
        registrationButton.setTitleColor(UIColor(red: 0.7, green: 0.46, blue: 0.97, alpha: 1), for: .normal)
        registrationButton.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        registrationButton.addTarget(self, action: #selector(registration), for: .touchUpInside)
        
        view.addSubviews(noAccountLabel, registrationButton)
        
        noAccountLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
        }
        registrationButton.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
            make.leading.equalTo(noAccountLabel.snp.trailing)
        }
        
        return view
    }()
    
    
    // - MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        keyboardWhenTappedAround()
    }
    
    
    // - MARK: Setup views
    func setupViews() {
        view.addSubviews(greetingsLabel, logInLabel, emailLabel, emailTextField, mailIconImageView, validationLabel, passwordLabel, passwordTextField, keyIcon, showPasswordButton, forgotPasswordButton, logInButton, noAccountView)
        logInButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
    }
    
    
    // - MARK: Setup constraints
    func setupConstraints() {
        greetingsLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalTo(24)
        }
        logInLabel.snp.makeConstraints { make in
            make.top.equalTo(greetingsLabel.snp.bottom).offset(4)
            make.leading.equalTo(24)
        }
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(logInLabel.snp.bottom).offset(32)
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
        if validationLabel.text == nil {
            passwordLabel.snp.makeConstraints { make in
                make.top.equalTo(emailTextField.snp.bottom).offset(13)
                make.leading.equalTo(24)
            }
        } else {
            validationLabel.snp.makeConstraints { make in
                make.top.equalTo(emailTextField.snp.bottom).offset(13)
                make.leading.equalTo(24)
            }
            passwordLabel.snp.makeConstraints { make in
                make.top.equalTo(validationLabel.snp.bottom).offset(13)
                make.leading.equalTo(24)
            }
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
        forgotPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(17)
            make.leading.equalTo(24)
            make.trailing.equalTo(-24)
            make.height.equalTo(22)
        }
        logInButton.snp.makeConstraints { make in
            make.top.equalTo(forgotPasswordButton.snp.bottom).offset(40)
            make.leading.equalTo(24)
            make.trailing.equalTo(-24)
            make.height.equalTo(56)
        }
        noAccountView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logInButton.snp.bottom).offset(24)
            make.height.equalTo(22)
        }
    }
    
    
    // - MARK: Logic
    @objc func showPassword(_ sender: UIButton) {
        if sender == showPasswordButton {
            passwordTextField.isSecureTextEntry.toggle()
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
    
    
    @objc func signIn() {
        SVProgressHUD.setContainerView(self.view)
        SVProgressHUD.show()
        
        let email = emailTextField.text!
        let password = passwordTextField.text!
        let isValidateEmail = self.validation.validateEmailId(emailID: email)
        
        if email.isEmpty || password.isEmpty {
            SVProgressHUD.dismiss()
            validationLabel.text = "Please fill all required fields"
            passwordLabel.snp.removeConstraints()
            setupConstraints()
            return
        }
       
        if isValidateEmail == false {
            SVProgressHUD.dismiss()
            emailTextField.layer.borderColor = UIColor(red: 1.00, green: 0.25, blue: 0.17, alpha: 1.00).cgColor
            validationLabel.text = "Қате формат"
            passwordLabel.snp.removeConstraints()
            setupConstraints()
            return
        }
        
        
        let parameters = ["email": email, "password": password]
        
        AF.request(Urls.SIGN_IN_URL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseData { response in
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
    
    func startApp() {
        let tabBarVC = TabBarController()
        tabBarVC.modalPresentationStyle = .fullScreen
        present(tabBarVC, animated: true)
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
    
    @objc func registration() {
        let signUpVC = SignUpViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
}

