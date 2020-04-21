//
//  SectionView.swift
//  SmartFingers
//
//  Created by DCLab on 10/1/19.
//  Copyright © 2019 Aigerim Janaliyeva. All rights reserved.
//

import Foundation
import UIKit

class SectionView: UIView {

    //MARK:- Variables:
    var section: Int!
    
    let language = UserDefaults.standard.string(forKey: "language")!

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Section name"
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var expandCloseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }()
    
    // MARK: - Methods
    override init(frame:CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        self.backgroundColor = UIColor.lightGray
        [nameLabel, expandCloseButton].forEach(self.addSubview)
        
        nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
//        nameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -48).isActive = true
        
        expandCloseButton.titleLabel?.text = kText.languages[language]?["close"] ?? "Close"
        
        expandCloseButton.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor).isActive = true
        expandCloseButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        expandCloseButton.heightAnchor.constraint(equalToConstant: 40).isActive = true

        
    }
    
}


