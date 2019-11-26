//
//  HomeCell.swift
//  SmartFingers
//
//  Created by DCLab on 11/21/19.
//  Copyright © 2019 Aigerim Janaliyeva. All rights reserved.
//

import Foundation
import UIKit

class HomeCell: UITableViewCell {
    
    let screenSize: CGRect = UIScreen.main.bounds
    let labelColor = UIColor(red: 255/255, green: 247/255, blue: 214/255, alpha: 1)
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    var leftImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Day 1"
        label.textColor = UIColor(red: 255/255, green: 247/255, blue: 214/255, alpha: 1)
        let font = UIFont(name: "Avenir-Heavy", size: 40)
        label.font = font
        label.numberOfLines = 2
        label.layer.shadowColor = UIColor(red: 69/255, green: 70/255, blue: 85/255, alpha: 1).cgColor
        label.layer.shadowRadius = 1.0
        label.layer.shadowOpacity = 7.0
        label.layer.shadowOffset = CGSize(width: 2, height: 2)
        label.layer.masksToBounds = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
//        self.selectionStyle = .none
        [nameLabel,leftImageView].forEach({
            addSubview($0)
        })
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(red: 69/255, green: 70/255, blue: 85/255, alpha: 1)
        self.selectedBackgroundView = bgColorView
        
        leftImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        leftImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        leftImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        leftImageView.heightAnchor.constraint(equalTo: leftImageView.widthAnchor).isActive = true
        
        nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: leftImageView.rightAnchor, constant: 20).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -40).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true


    }
    
}
