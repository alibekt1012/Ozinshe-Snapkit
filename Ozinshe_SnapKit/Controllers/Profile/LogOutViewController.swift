//
//  LogOutViewController.swift
//  Ozinshe_SnapKit
//
//  Created by Almat Alibekov on 14.11.2023.
//

import UIKit

class LogOutViewController: UIViewController, UIGestureRecognizerDelegate {
    
    
    private lazy var backgroundView: UIView = {
       let view = UIView()
        view.backgroundColor = .white

        let lineView = UIView()
        lineView.backgroundColor = UIColor(red: 0.82, green: 0.84, blue: 0.86, alpha: 1)
        lineView.layer.cornerRadius = 2.5
        
        let logOutLabel = UILabel()
        logOutLabel.text = "Log Out"
        logOutLabel.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        logOutLabel.textColor = UIColor(red: 0.07, green: 0.09, blue: 0.15, alpha: 1)
        
        let confirmationLabel = UILabel()
        confirmationLabel.text = "Are your sure you want to log out?"
        confirmationLabel.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        confirmationLabel.textColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1)
        
        let yesButton = UIButton()
        yesButton.setTitle("Yes, log out", for: .normal)
        yesButton.backgroundColor = UIColor(red: 0.5, green: 0.18, blue: 0.99, alpha: 1)
        yesButton.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        yesButton.layer.cornerRadius = 12
        yesButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        
        let noButton = UIButton()
        noButton.setTitle("No", for: .normal)
        noButton.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        noButton.setTitleColor(UIColor(red: 0.33, green: 0.08, blue: 0.78, alpha: 1), for: .normal)
        noButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
    
       
        view.addSubview(lineView)
        view.addSubview(logOutLabel)
        view.addSubview(confirmationLabel)
        view.addSubview(yesButton)
        view.addSubview(noButton)
    
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(21)
            make.centerX.equalToSuperview()
            make.width.equalTo(64)
            make.height.equalTo(5)
        }
        
        logOutLabel.snp.makeConstraints { make in
            make.leading.equalTo(24)
            make.top.equalTo(lineView.snp.bottom).offset(24)
        }
        confirmationLabel.snp.makeConstraints { make in
            make.top.equalTo(logOutLabel.snp.bottom).offset(8)
            make.leading.equalTo(24)
            make.trailing.equalTo(-24)
        }
        yesButton.snp.makeConstraints { make in
            make.top.equalTo(confirmationLabel.snp.bottom).offset(32)
            make.leading.equalTo(24)
            make.trailing.equalTo(-24)
            make.height.equalTo(56)
        }
        noButton.snp.makeConstraints { make in
            make.top.equalTo(yesButton.snp.bottom).offset(8)
            make.leading.equalTo(24)
            make.trailing.equalTo(-24)
            make.height.equalTo(56)
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
    
    func setupViews() {
        view.addSubview(backgroundView)
    }
    
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
    
    @objc func logOut(_ sender: Any) {
       UserDefaults.standard.removeObject(forKey: "accessToken")
       //SignInNavigationViewController
       
       let rootVC = SignInViewController()
        rootVC.modalPresentationStyle = .overFullScreen
        present(rootVC, animated: true)
       
       let appDelegate  = UIApplication.shared.delegate as! AppDelegate
       appDelegate.window?.rootViewController = rootVC
       appDelegate.window?.makeKeyAndVisible()
       
   }
    
}
