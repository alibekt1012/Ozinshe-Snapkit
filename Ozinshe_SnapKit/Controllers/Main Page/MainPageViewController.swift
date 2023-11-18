//
//  MainPageViewController.swift
//  Ozinshe_SnapKit
//
//  Created by Almat Alibekov on 06.11.2023.
//

import UIKit

class MainPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    var mainMovies: [MainMovie] = []
    
    private lazy var tableView: UITableView = {
       let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        addNavBarImage()
    }
    
    func addNavBarImage() {
        let image = UIImage(named: "LogoMainPage")!
        
        let logoImageView = UIImageView(image: image)
        let imageItem = UIBarButtonItem.init(customView: logoImageView)
        navigationItem.leftBarButtonItem = imageItem
        
    }
}



extension MainPageViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
}
