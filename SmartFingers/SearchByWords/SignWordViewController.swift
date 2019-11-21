//
//  SignWordViewController.swift
//  SmartFingers
//
//  Created by DCLab on 9/19/19.
//  Copyright © 2019 Aigerim Janaliyeva. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import AVKit

class SignWordViewController: UIViewController, UINavigationBarDelegate {
    
    var navbar = UINavigationBar(frame: CGRect(x: 0, y: 25, width: UIScreen.main.bounds.width, height: 75))
    var navItem = UINavigationItem()
    var text = ""
    var tapped = false
    var player = AVPlayer()
    var playerLayer = AVPlayerLayer()
    
    var starTapped = false
    
    var word: Word?
    
    var descriptionTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Text"
        label.textColor = .white
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.numberOfLines = 10
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .red
        return label
    }()
    
    var addToFavourites: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setupNavBar()
        setVideo()
    }
    
    func setupNavBar() {
        let height: CGFloat = 75
        navbar.backgroundColor = UIColor.white
        navbar.delegate = self
        navItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(back))
        navbar.items = [navItem]
        navItem.title = word?.translation
        descriptionTextLabel.text = word?.translation
        view.addSubview(navbar)
        self.view.frame = CGRect(x: 0, y: height, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height - height))
    }
    
    func setVideo(){
        guard let videoName = word?.video else { return }
        guard let path = Bundle.main.path(forResource: videoName, ofType:"mp4", inDirectory: "Videos") else {
            print("video not found")
            return
        }
        player = AVPlayer(url: URL(fileURLWithPath: path))
        playerLayer = AVPlayerLayer(player: player)
        //        playerLayer.frame = CGRect(x: (self.view.bounds.width-100)/2, y: (self.view.bounds.height-100)/2, width: self.view.bounds.width-20, height: self.view.bounds.height/3) // CGRect(origin: self.view.bounds.origin, size: CGSize(width: 100, height: 100))
        self.view.layer.borderWidth = 1
        self.view.layer.borderColor = UIColor(red:222/255.0, green:225/255.0, blue:227/255.0, alpha: 1.0).cgColor
        playerLayer.frame = CGRect(x: 0, y: 110, width: self.view.bounds.width, height: 240)
        self.view.layer.addSublayer(playerLayer)
        player.play()
        play()
        
    }
    
    func pause() {
        player.pause()
    }
    
    func play() {
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { [weak self] _ in
            self?.player.seek(to: CMTime.zero)
            self?.player.play()
        }
    }
    
    
    @objc func back(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    func setUpView(){
        self.view.backgroundColor = .white
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(starTapped(tapGestureRecognizer:)))
        addToFavourites.addGestureRecognizer(gesture)
        addToFavourites.isUserInteractionEnabled = true
        
        [descriptionTextLabel, addToFavourites].forEach(self.view.addSubview)
        descriptionTextLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//        descriptionTextLabel.centerYAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100).isActive = true
        descriptionTextLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40).isActive = true

        descriptionTextLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        descriptionTextLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -40).isActive = true
        
        if starTapped {
            addToFavourites.image = UIImage(named: "heart_infilled")
            starTapped = false
        } else {
            addToFavourites.image = UIImage(named: "heart_filled1")
            starTapped = true
        }
        
        addToFavourites.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -self.view.frame.width/4).isActive = true
        addToFavourites.bottomAnchor.constraint(equalTo: descriptionTextLabel.topAnchor, constant: -20).isActive = true //-65
        //        addToFavourites.centerYAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100).isActive = true
        addToFavourites.heightAnchor.constraint(equalToConstant: 100).isActive = true
        addToFavourites.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        
    }
    
    
    func setImageFavourite() {
        if starTapped {
            addToFavourites.image = UIImage(named: "heart_infilled")
            starTapped = false
        } else {
            addToFavourites.image = UIImage(named: "heart_filled1")
            starTapped = true
        }
        
    }
    
    @objc func starTapped(tapGestureRecognizer: UITapGestureRecognizer){
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        if tappedImage == addToFavourites {
            setImageFavourite()
        }
    }
    
    
    
    
}

