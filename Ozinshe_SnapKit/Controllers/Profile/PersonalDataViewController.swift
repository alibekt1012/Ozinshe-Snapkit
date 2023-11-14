//
//  PersonalDataViewController.swift
//  Ozinshe_SnapKit
//
//  Created by Almat Alibekov on 06.11.2023.
//

import UIKit
import SnapKit
import SVProgressHUD
import SwiftyJSON
import Alamofire

protocol PersonalDataDelegate: AnyObject {
    func personalDataChanged(updatedData: Profile)
}

class PersonalDataViewController: UIViewController {
    
    var userData: Profile?
    var delegate: PersonalDataDelegate?

    
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
        textField.setInputViewDatePicker(target: self, selector: #selector(tapDone))
        
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
        button.addTarget(self, action: #selector(saveChanges), for: .touchUpInside)
        return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        navigationItem.title = " Жеке деректер"
        
        setupViews()
        setupConstraints()
        setupData()
        
    }
    
    
    @objc func saveChanges() {
        SVProgressHUD.setContainerView(self.view)
        SVProgressHUD.show()
        
        let email = nameTextField.text!
        let birthDate = birthdayTextField.text!
        let phoneNumber = phoneTextField.text!
        let language = userData?.language
        
        
        let parameters = ["name" : email, "birthDate" : birthDate, "phoneNumber" : phoneNumber, "language" : language]
        
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        
        AF.request("http://api.ozinshe.com/core/V1/user/profile/", method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseData { response in
            
            SVProgressHUD.dismiss()
            
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
            }
            
            if response.response?.statusCode == 200 {
                self.userData?.name = self.nameTextField.text!
                self.userData?.birthDate = self.birthdayTextField.text!
                self.userData?.phoneNumber = self.phoneTextField.text!
                self.delegate?.personalDataChanged(updatedData: self.userData!)
                SVProgressHUD.showSuccess(withStatus: "Changes applied")
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
            make.height.equalTo(56)
            make.bottom.equalToSuperview().offset(-42)
        }
    }
    
    func setupData() {
        guard let userData = userData else {
            return
        }
    
        nameTextField.text = userData.name
        phoneTextField.text = userData.phoneNumber
        birthdayTextField.text = userData.birthDate
        emailTextField.text = userData.user_email
        print(userData)
    }
    
    @objc func tapDone() {
            if let datePicker = self.birthdayTextField.inputView as? UIDatePicker { // 2-1
                let dateformatter = DateFormatter() // 2-2
                dateformatter.dateFormat = "yyyy-MM-dd" // 2-3
                self.birthdayTextField.text = dateformatter.string(from: datePicker.date) //2-4
            }
            self.birthdayTextField.resignFirstResponder() // 2-5
        }

} 
