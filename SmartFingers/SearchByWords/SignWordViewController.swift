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
        descriptionTextLabel.text = navItem.title
        view.addSubview(navbar)
        self.view.frame = CGRect(x: 0, y: height, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height - height))
    }
    
    func setVideo(){
        
        guard let path = Bundle.main.path(forResource: "video", ofType:"mp4") else {
            print("video not found")
            return
        }
        player = AVPlayer(url: URL(fileURLWithPath: path))
        playerLayer = AVPlayerLayer(player: player)
        //        playerLayer.frame = CGRect(x: (self.view.bounds.width-100)/2, y: (self.view.bounds.height-100)/2, width: self.view.bounds.width-20, height: self.view.bounds.height/3) // CGRect(origin: self.view.bounds.origin, size: CGSize(width: 100, height: 100))
        self.view.layer.borderWidth = 1
        self.view.layer.borderColor = UIColor(red:222/255.0, green:225/255.0, blue:227/255.0, alpha: 1.0).cgColor
        playerLayer.frame = CGRect(x: 0, y: 150, width: self.view.bounds.width, height: 240)
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
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let view = UIView(frame: CGRect(x: 0, y: 150, width: self.view.bounds.width, height: 240))
//        if let touch = touches.first {
//            if touch. location(in: view) {
//                if tapped {
//                    play()
//                    tapped = false
//                } else {
//                    pause()
//                    tapped = true
//                }
//            }
//        }
//        super.touchesBegan(touches, with: event)
//    }
    
    //    @objc func videoTapped(tapGestureRecognizer: UITapGestureRecognizer){
    //        //        let tappedVideo = tapGestureRecognizer. as! AVPlayer
    //        if tapped {
    //            pause()
    //            tapped = true
    //        } else {
    //            play()
    //            tapped = true
    //        }
    //    }
    
    @objc func back(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    func setUpView(){
        self.view.backgroundColor = .white
        [descriptionTextLabel].forEach(self.view.addSubview)
        descriptionTextLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        descriptionTextLabel.centerYAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100).isActive = true
        descriptionTextLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        descriptionTextLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -40).isActive = true
        
        
    }
    
    
    
    
}

