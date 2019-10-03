//
//  FingerSpellingViewController.swift
//  SmartFingers
//
//  Created by DCLab on 10/1/19.
//  Copyright © 2019 Aigerim Janaliyeva. All rights reserved.
//

import Foundation
import UIKit
import CoreML

class FingerSpellingViewController: UIViewController {
    
    /** Tasks:
     - Camera view
     - nav bar
     - Text labels x3
     */
    
    //MARK:- Variables
    
    
    //imageView:
    var cameraView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var textView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()



    //MARK:- Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }

    func setUpView() {
        self.view.backgroundColor = .gray
        [cameraView, textView].forEach(self.view.addSubview)
                
        cameraView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        cameraView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 75).isActive = true
        cameraView.heightAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        cameraView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
        textView.centerXAnchor.constraint(equalTo: cameraView.centerXAnchor).isActive = true
        textView.topAnchor.constraint(equalTo: cameraView.bottomAnchor, constant: 30).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        textView.widthAnchor.constraint(equalTo: cameraView.widthAnchor, constant: -20).isActive = true
        
        
    }

    
}


