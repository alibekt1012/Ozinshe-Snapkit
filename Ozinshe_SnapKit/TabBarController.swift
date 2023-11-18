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
        
        let profileNavigationVC = UINavigationController(rootViewController: profileVC)
        
        let favoriteNavigationVC = UINavigationController(rootViewController: favoritesVC)
        
        let searchNavigationVC = UINavigationController(rootViewController: searchVC)
        
        let mainPageNavigationVC = UINavigationController(rootViewController: mainPageVC)
        
        
        
        mainPageNavigationVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "home"), selectedImage:  UIImage(named: "homeSelected"))
        searchNavigationVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "search"), selectedImage: UIImage(named: "searchSelected"))
        favoriteNavigationVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "favorites"), selectedImage: UIImage(named: "favoritesSelected"))
        profileNavigationVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "profile"), selectedImage: UIImage(named: "profileSelected"))
        
        setViewControllers([mainPageNavigationVC, searchNavigationVC, favoriteNavigationVC, profileNavigationVC], animated: false)
       
    }

}
