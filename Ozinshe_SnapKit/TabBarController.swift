//
//  TabBarController.swift
//  Ozinshe_SnapKit
//
//  Created by Almat Alibekov on 06.11.2023.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
    
    func setupTabs() {
        
        let mainPageVC = MainPageViewController()
        let searchVC = SearchViewController()
        let favoritesVC = FavoritesViewController()
        let profileVC = ProfileViewController()
        
        mainPageVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "home"), selectedImage:  UIImage(named: "homeSelected"))
        searchVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "search"), selectedImage: UIImage(named: "searchSelected"))
        favoritesVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "favorites"), selectedImage: UIImage(named: "favoritesSelected"))
        profileVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "profile"), selectedImage: UIImage(named: "profileSelected"))
        
        setViewControllers([mainPageVC, searchVC, favoritesVC, profileVC], animated: false)
       
    }

}
