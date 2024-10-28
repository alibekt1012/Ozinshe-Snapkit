//
//  MoviePlayerViewController.swift
//  Ozinshe_SnapKit
//
//  Created by Almat Alibekov on 30.11.2023.
//

import UIKit
import YouTubePlayer

class MoviePlayerViewController: UIViewController {

    var video_link = ""
    
    private lazy var player: YouTubePlayerView = {
       let view = YouTubePlayerView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        player.loadVideoID(video_link)
        
    }
    
    func setupViews() {
        view.addSubview(player)
        view.backgroundColor = .white
    }
    
    func setupConstraints() {
        player.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }


}
