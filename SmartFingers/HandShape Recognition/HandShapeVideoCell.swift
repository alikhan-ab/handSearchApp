//
//  HandShapeVideoCell.swift
//  SmartFingers
//
//  Created by Aigerim on 11/8/19.
//  Copyright © 2019 Aigerim Janaliyeva. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import AVKit

class HandShapeVideoCell: UITableViewCell {
  
    var avPlayer: AVPlayer?
    var avPlayerLayer: AVPlayerLayer?
    var paused: Bool = false
    
    var word: Word?
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Day 1"
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let videoImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor(r: 87, g: 69, b: 93)
        view.layer.cornerRadius = 10
        view.image = #imageLiteral(resourceName: "sample1")
        view.contentMode = .scaleToFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let videoView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 87, g: 69, b: 93)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(nameLabel)
        addSubview(videoView)

        nameLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        
        videoView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        videoView.heightAnchor.constraint(equalToConstant: self.bounds.height).isActive = true
        videoView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        videoView.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 30).isActive = true
        videoView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        print("Interesting")

        guard let file = Bundle.main.path(forResource: "5", ofType: "mp4", inDirectory: "Videos") else {
            print("\n----- Didn't find ---- \n")
            return
        }
        avPlayer = AVPlayer(url: URL(fileURLWithPath: file))
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        //        You need to have different variations
        //        according to the device so as the avplayer fits well
//        if UIScreen.main.bounds.width == 375 {
//            let widthRequired = videoView.frame.size.width - 20
//            avPlayerLayer?.frame = CGRect.init(x: 0, y: 0, width: widthRequired, height: widthRequired/1.78)
//        }else if UIScreen.main.bounds.width == 320 {
//            avPlayerLayer?.frame = CGRect.init(x: 0, y: 0, width: (videoView.frame.size.width - 20), height: videoView.frame.size.height)
//        }else{
//            let widthRequired = videoView.frame.size.width
//            avPlayerLayer?.frame = CGRect.init(x: 0, y: 0, width: widthRequired, height: videoView.frame.size.height)
//        }

        avPlayerLayer?.frame = CGRect.init(x: 0, y: -15, width: 100, height: 80)
        self.backgroundColor = .clear

        avPlayerLayer?.videoGravity = AVLayerVideoGravity.resizeAspect
        avPlayer?.volume = 3
        avPlayer?.actionAtItemEnd = .none
        videoView.layer.insertSublayer(avPlayerLayer!, at: 0)
//        videoView.layer.addSublayer(avPlayerLayer!)
        avPlayer?.play()

        // This notification is fired when the video ends, you can handle it in the method.
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.playerItemDidReachEnd(notification:)),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: avPlayer?.currentItem)
        
        
    }
    func stopPlayback(){
        self.avPlayer?.pause()
    }

    func startPlayback(){
        self.avPlayer?.play()
    }

    // A notification is fired and seeker is sent to the beginning to loop the video again
    @objc func playerItemDidReachEnd(notification: Notification) {
        let p: AVPlayerItem = notification.object as! AVPlayerItem
        p.seek(to: CMTime.zero)
    }


    
    
}

