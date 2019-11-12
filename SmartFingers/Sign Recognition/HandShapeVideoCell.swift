//
//  HandShapeVideoCell.swift
//  SmartFingers
//
//  Created by Aigerim on 11/8/19.
//  Copyright © 2019 Aigerim Janaliyeva. All rights reserved.
//

import Foundation
import UIKit

class HandShapeVideoCell: UITableViewCell {
    
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
        view.backgroundColor = UIColor.red
        view.layer.cornerRadius = 10
        view.image = #imageLiteral(resourceName: "sample1")
        view.contentMode = .scaleToFill
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
        //        addSubview(cellView)
        addSubview(nameLabel)
        addSubview(videoImageView)

//        self.selectionStyle = .none
        
        //        NSLayoutConstraint.activate([
        //            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
        //            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
        //            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
        //            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        //            ])
        nameLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
//        nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -100).isActive = true
        
        videoImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
//        videoImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        videoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        videoImageView.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 50).isActive = true
        videoImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        
    }
    
}

