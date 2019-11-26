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
//    var data: CustomData? {
//        didSet {
//            guard let data = data else { return }
//            bg.image = data.backgroundImage
//        }
//    }
    
    var data: Shape? {
        didSet {
            guard let data = data else { return }
            bg.image = data.image
            if data.status == .loading {
                bg.layer.borderColor = UIColor.gray.cgColor
            } else if data.status == .accepted {
                bg.layer.borderColor = UIColor.green.cgColor
                
            } else {
                bg.layer.borderColor = UIColor.red.cgColor
            }
            
            bg.layer.borderWidth = 1.5
        }
    }
    
    fileprivate let bg: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
                
        contentView.addSubview(bg)

        bg.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        bg.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        bg.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        bg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
