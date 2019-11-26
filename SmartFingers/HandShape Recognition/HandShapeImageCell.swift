//
//  HandShapeImageCell.swift
//  SmartFingers
//
//  Created by DCLab on 11/7/19.
//  Copyright © 2019 Aigerim Janaliyeva. All rights reserved.
//

import Foundation
import UIKit

struct CustomData {
    var title: String
    var url: String
    var backgroundImage: UIImage
}

class HandShapeImageCell: UICollectionViewCell {
    
    var data: UIImage? {
        didSet {
            guard let data = data else { return }
            bg.image = data
        }
    }
        
    var isEmpty = false
    
    fileprivate let bg: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        return iv
    }()
    
    lazy var emptyView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 169, g: 170, b: 188)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        return view
    }()
    
    lazy var addLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Add image"
        label.contentMode = .center
        label.numberOfLines = 2
        label.backgroundColor = .clear
        label.textColor = UIColor(red: 69/255, green: 70/255, blue: 85/255, alpha: 1)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
                
        if isEmpty {
            contentView.addSubview(emptyView)
            emptyView.addSubview(addLabel)
            emptyView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
            emptyView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
            emptyView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
            emptyView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
            
            addLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
            addLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
            addLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor).isActive = true
            addLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor).isActive = true
            addLabel.bottomAnchor.constraint(equalTo: emptyView.bottomAnchor).isActive = true
        } else {
            contentView.addSubview(bg)
            bg.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
            bg.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
            bg.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
            bg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
