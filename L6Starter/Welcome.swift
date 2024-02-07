//
//  Welcome.swift
//  L6Starter
//
//  Created by Sam Friedman on 12/2/22.
//

import UIKit

import youtube_ios_player_helper

import AVFoundation


class Welcome: UIViewController {
    
    
    let logoView = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Welcome"
        
        logoView.image = UIImage(named:"logo")
        logoView.translatesAutoresizingMaskIntoConstraints = false
        
        logoView.layer.cornerRadius = 20
        logoView.clipsToBounds = true
        
        view.addSubview(logoView)
        
        setupConstraints()
    }
    
    
    
    
    func setupConstraints() {
                NSLayoutConstraint.activate([
                    logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    logoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                    logoView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
                    logoView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
                ])
    }
    
    
}
