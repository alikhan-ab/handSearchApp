//
//  ViewController.swift
//  SmartFingers
//
//  Created by Aigerim on 9/5/19.
//  Copyright © 2019 Aigerim Janaliyeva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK:- Variables
    
    //imageView:
    var dictionaryWordsImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var categoryImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var fingerSpellImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var signImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //Labels:
    var dictionaryWordsNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Words"
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        return label
    }()
    var categoryNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Categories"
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        return label
    }()
    var fingerSpellNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Finger Spelling"
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 4

        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        return label
    }()
    var signNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign Recognition"
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 4
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    //MARK:- Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        gestureRecognizer()
    }
    
    func gestureRecognizer(){
        let gesture1 = UITapGestureRecognizer(target: self, action: #selector(wordsAction(tapGestureRecognizer:)))
        dictionaryWordsImageView.addGestureRecognizer(gesture1)
        dictionaryWordsImageView.isUserInteractionEnabled = true
        
        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(wordsAction(tapGestureRecognizer:)))
        categoryImageView.addGestureRecognizer(gesture2)
        categoryImageView.isUserInteractionEnabled = true
        
        let gesture3 = UITapGestureRecognizer(target: self, action: #selector(wordsAction(tapGestureRecognizer:)))
        fingerSpellImageView.addGestureRecognizer(gesture3)
        fingerSpellImageView.isUserInteractionEnabled = true
        
        let gesture4 = UITapGestureRecognizer(target: self, action: #selector(wordsAction(tapGestureRecognizer:)))
        signImageView.addGestureRecognizer(gesture4)
        signImageView.isUserInteractionEnabled = true
        
    }
    
    func setUpView(){
        self.view.backgroundColor = .yellow
        [dictionaryWordsImageView, dictionaryWordsNameLabel, categoryImageView, categoryNameLabel, fingerSpellImageView, signImageView, fingerSpellNameLabel, signNameLabel].forEach(self.view.addSubview)
                
        // dictionary:
        dictionaryWordsImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -self.view.bounds.width/4).isActive = true
        dictionaryWordsImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -self.view.bounds.height/4).isActive = true
        dictionaryWordsImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        dictionaryWordsImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        dictionaryWordsNameLabel.centerXAnchor.constraint(equalTo: dictionaryWordsImageView.centerXAnchor).isActive = true
        dictionaryWordsNameLabel.topAnchor.constraint(equalTo: dictionaryWordsImageView.bottomAnchor, constant: 10).isActive = true
        dictionaryWordsNameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        dictionaryWordsNameLabel.widthAnchor.constraint(equalTo: dictionaryWordsImageView.widthAnchor).isActive = true
        
        //categories:
        categoryImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: self.view.bounds.width/4).isActive = true
        categoryImageView.centerYAnchor.constraint(equalTo: dictionaryWordsImageView.centerYAnchor).isActive = true
        categoryImageView.heightAnchor.constraint(equalTo: dictionaryWordsImageView.heightAnchor).isActive = true
        categoryImageView.widthAnchor.constraint(equalTo: dictionaryWordsImageView.widthAnchor).isActive = true
        
        categoryNameLabel.centerXAnchor.constraint(equalTo: categoryImageView.centerXAnchor).isActive = true
        categoryNameLabel.topAnchor.constraint(equalTo: categoryImageView.bottomAnchor, constant: 10).isActive = true
        categoryNameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        categoryNameLabel.widthAnchor.constraint(equalTo: categoryImageView.widthAnchor).isActive = true
        
//        let const = self.view.topAnchor
//        dictionaryWordsImageView.topAnchor
        let distance = self.view.bounds.height/8//self.view.frame.minY + dictionaryWordsImageView.frame.minY
        
        //fingerSpelling:
        fingerSpellImageView.centerXAnchor.constraint(equalTo: dictionaryWordsImageView.centerXAnchor).isActive = true
        fingerSpellImageView.topAnchor.constraint(equalTo: dictionaryWordsNameLabel.bottomAnchor, constant: distance).isActive = true
//        fingerSpellImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: self.view.bounds.height/4).isActive = true
        fingerSpellImageView.heightAnchor.constraint(equalTo: dictionaryWordsImageView.heightAnchor).isActive = true
        fingerSpellImageView.widthAnchor.constraint(equalTo: dictionaryWordsImageView.widthAnchor).isActive = true
        
        fingerSpellNameLabel.centerXAnchor.constraint(equalTo: fingerSpellImageView.centerXAnchor).isActive = true
        fingerSpellNameLabel.topAnchor.constraint(equalTo: fingerSpellImageView.bottomAnchor, constant: 10).isActive = true
        fingerSpellNameLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        fingerSpellNameLabel.widthAnchor.constraint(equalTo: fingerSpellImageView.widthAnchor).isActive = true
        
        //sign recognition:
        signImageView.centerXAnchor.constraint(equalTo: categoryImageView.centerXAnchor).isActive = true
        signImageView.centerYAnchor.constraint(equalTo: fingerSpellImageView.centerYAnchor).isActive = true
        signImageView.heightAnchor.constraint(equalTo: dictionaryWordsImageView.heightAnchor).isActive = true
        signImageView.widthAnchor.constraint(equalTo: dictionaryWordsImageView.widthAnchor).isActive = true
        
        signNameLabel.centerXAnchor.constraint(equalTo: signImageView.centerXAnchor).isActive = true
        signNameLabel.topAnchor.constraint(equalTo: signImageView.bottomAnchor, constant: 10).isActive = true
        signNameLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        signNameLabel.widthAnchor.constraint(equalTo: signImageView.widthAnchor).isActive = true
        
        
        [dictionaryWordsImageView, categoryImageView, fingerSpellImageView, signImageView].forEach { (view) in
            view.layer.masksToBounds = true
            view.layer.borderWidth = 1.5
            view.layer.borderColor = UIColor.white.cgColor
            view.layer.cornerRadius = 35
            imageViews(imageView: view)
        }
        
    }
    
    func imageViews(imageView: UIImageView) {
        let imgListArray: NSMutableArray = []
        for countValue in 1...10 {
            let strImageName : String = "weather\(countValue)"
            let image = UIImage(named: strImageName)!
            imgListArray.add(image)
        }
        imageView.animationImages = imgListArray as? [UIImage]
        imageView.animationDuration = 1.0
        imageView.startAnimating()
    }
    
    @objc func wordsAction(tapGestureRecognizer: UITapGestureRecognizer){
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        if tappedImage == dictionaryWordsImageView {
            let dictionaryByWordsVC = DictionaryByWordsVC()
            self.present(dictionaryByWordsVC, animated: true, completion: nil)
        }
        if tappedImage == categoryImageView {
            let categoryVC = CategoriesViewController()
            self.present(categoryVC, animated: true, completion: nil)
        }
        if tappedImage == fingerSpellImageView {
            let fingerSpellingVC = FingerSpellingViewController()
            self.present(fingerSpellingVC, animated: true, completion: nil)
        }
        if tappedImage == signImageView {
            let signVC = SignViewController()
            self.present(signVC, animated: true, completion: nil)
        }
    }
    
}

