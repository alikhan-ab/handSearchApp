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
        label.text = "Search by Hand Shape"
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 4
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // Favourites:
    var starImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "heart_filled2")
        return view
    }()
    var catImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "ginger-cat-productive-work")
        view.contentMode = .scaleAspectFit
        return view
    }()
 
    //bacground animation:
    let gradient = CAGradientLayer()
    var gradientSet = [[CGColor]]()
    var currentGradient: Int = 0
    
//    let gradientOne = UIColor(red: 48/255, green: 62/255, blue: 103/255, alpha: 1).cgColor
//    let gradientTwo = UIColor(red: 244/255, green: 88/255, blue: 53/255, alpha: 1).cgColor
    let gradientOne = UIColor(red: 249/255, green: 149/255, blue: 127/255, alpha: 1).cgColor
    let gradientTwo = UIColor(red: 242/255, green: 245/255, blue: 208/255, alpha: 1).cgColor
    let gradientThree = UIColor(red: 196/255, green: 70/255, blue: 107/255, alpha: 1).cgColor
    
    //MARK:- Methods
    override func viewDidLoad() {
        super.viewDidLoad()
//        setUpView()
//        gestureRecognizer()
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
        
        let gesture5 = UITapGestureRecognizer(target: self, action: #selector(wordsAction(tapGestureRecognizer:)))
        starImageView.addGestureRecognizer(gesture5)
        starImageView.isUserInteractionEnabled = true
        
    }
    
    func setUpView(){
        self.view.backgroundColor = .yellow
        [dictionaryWordsImageView, dictionaryWordsNameLabel, categoryImageView, categoryNameLabel, signImageView, signNameLabel, starImageView].forEach(self.view.addSubview)
        let dist_width = self.view.bounds.width/4
        let distance = self.view.bounds.height/8//self.view.frame.minY + dictionaryWordsImageView.frame.minY

        // dictionary:
        dictionaryWordsImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -dist_width).isActive = true
//        dictionaryWordsImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -dist_width).isActive = true
        dictionaryWordsImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: distance).isActive = true
        dictionaryWordsImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        dictionaryWordsImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        dictionaryWordsNameLabel.centerXAnchor.constraint(equalTo: dictionaryWordsImageView.centerXAnchor).isActive = true
        dictionaryWordsNameLabel.topAnchor.constraint(equalTo: dictionaryWordsImageView.bottomAnchor, constant: 10).isActive = true
        dictionaryWordsNameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        dictionaryWordsNameLabel.widthAnchor.constraint(equalTo: dictionaryWordsImageView.widthAnchor).isActive = true
        
        //categories:
        categoryImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: dist_width).isActive = true
        categoryImageView.centerYAnchor.constraint(equalTo: dictionaryWordsImageView.centerYAnchor).isActive = true
        categoryImageView.heightAnchor.constraint(equalTo: dictionaryWordsImageView.heightAnchor).isActive = true
        categoryImageView.widthAnchor.constraint(equalTo: dictionaryWordsImageView.widthAnchor).isActive = true
        
        categoryNameLabel.centerXAnchor.constraint(equalTo: categoryImageView.centerXAnchor).isActive = true
        categoryNameLabel.topAnchor.constraint(equalTo: categoryImageView.bottomAnchor, constant: 10).isActive = true
        categoryNameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        categoryNameLabel.widthAnchor.constraint(equalTo: categoryImageView.widthAnchor).isActive = true
        
//        let const = self.view.topAnchor
//        dictionaryWordsImageView.topAnchor
        /*
        //fingerSpelling:
        fingerSpellImageView.centerXAnchor.constraint(equalTo: dictionaryWordsImageView.centerXAnchor).isActive = true
        fingerSpellImageView.topAnchor.constraint(equalTo: dictionaryWordsNameLabel.bottomAnchor, constant: distance*0.8).isActive = true
//        fingerSpellImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: self.view.bounds.height/4).isActive = true

        fingerSpellImageView.heightAnchor.constraint(equalTo: dictionaryWordsImageView.heightAnchor).isActive = true
        fingerSpellImageView.widthAnchor.constraint(equalTo: dictionaryWordsImageView.widthAnchor).isActive = true
        
        fingerSpellNameLabel.centerXAnchor.constraint(equalTo: fingerSpellImageView.centerXAnchor).isActive = true
        fingerSpellNameLabel.topAnchor.constraint(equalTo: fingerSpellImageView.bottomAnchor, constant: 10).isActive = true
        fingerSpellNameLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        fingerSpellNameLabel.widthAnchor.constraint(equalTo: fingerSpellImageView.widthAnchor).isActive = true
        */
        
        // favourites:
//        starImageView.centerXAnchor.constraint(equalTo: fingerSpellImageView.centerXAnchor).isActive = true
//        starImageView.topAnchor.constraint(equalTo: signNameLabel.bottomAnchor, constant: distance*0.6).isActive = true
//        starImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
//        starImageView.widthAnchor.constraint(equalTo: starImageView.heightAnchor).isActive = true
        
        starImageView.centerXAnchor.constraint(equalTo: dictionaryWordsImageView.centerXAnchor).isActive = true
        starImageView.topAnchor.constraint(equalTo: dictionaryWordsNameLabel.bottomAnchor, constant: distance*0.8).isActive = true
//        starImageView.heightAnchor.constraint(equalTo: dictionaryWordsImageView.heightAnchor).isActive = true
//        starImageView.widthAnchor.constraint(equalTo: dictionaryWordsImageView.widthAnchor).isActive = true
        starImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        starImageView.widthAnchor.constraint(equalTo: starImageView.heightAnchor).isActive = true
        
//        fingerSpellNameLabel.centerXAnchor.constraint(equalTo: fingerSpellImageView.centerXAnchor).isActive = true
//        fingerSpellNameLabel.topAnchor.constraint(equalTo: fingerSpellImageView.bottomAnchor, constant: 10).isActive = true
//        fingerSpellNameLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
//        fingerSpellNameLabel.widthAnchor.constraint(equalTo: fingerSpellImageView.widthAnchor).isActive = true
        
        //sign recognition:
        signImageView.centerXAnchor.constraint(equalTo: categoryImageView.centerXAnchor).isActive = true
        signImageView.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor).isActive = true
        signImageView.heightAnchor.constraint(equalTo: dictionaryWordsImageView.heightAnchor).isActive = true
        signImageView.widthAnchor.constraint(equalTo: dictionaryWordsImageView.widthAnchor).isActive = true
        
        signNameLabel.centerXAnchor.constraint(equalTo: signImageView.centerXAnchor).isActive = true
        signNameLabel.topAnchor.constraint(equalTo: signImageView.bottomAnchor, constant: 10).isActive = true
        signNameLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        signNameLabel.widthAnchor.constraint(equalTo: signImageView.widthAnchor).isActive = true
        

        
        
//        catImageView.centerXAnchor.constraint(equalTo: signNameLabel.centerXAnchor).isActive = true
////        catImageView.topAnchor.constraint(equalTo: signNameLabel.bottomAnchor, constant: distance*0.6).isActive = true
//        catImageView.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor).isActive = true
//        catImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
//        catImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        [dictionaryWordsImageView, categoryImageView, signImageView].forEach { (view) in
            view.layer.masksToBounds = true
            view.layer.borderWidth = 1.5
            view.layer.borderColor = gradientOne//UIColor.white.cgColor
            view.layer.cornerRadius = 35
            imageViews(imageView: view)
        }
        
        
        
        
    }
    
    func imageViews(imageView: UIImageView) {
        let imgListArray: NSMutableArray = []
        for countValue in 1...39 {
            let strImageName : String = "word\(countValue)"
            let image = UIImage(named: strImageName)!
            imgListArray.add(image)
        }
        imageView.animationImages = imgListArray as? [UIImage]
        imageView.animationDuration = 3.5
        imageView.contentMode = .scaleAspectFill
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
            let signVC = HandShapeVC()//SignViewController()
            self.present(signVC, animated: true, completion: nil)
        }
        if tappedImage == starImageView {
            let signVC = FavouriteViewController()
            self.present(signVC, animated: true, completion: nil)
        }
        
    }
    
    //Background Animation:
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        gradientSet.append([gradientOne, gradientTwo])
//        gradientSet.append([gradientTwo, gradientThree])
//        gradientSet.append([gradientThree, gradientOne])
        
        
        gradient.frame = self.view.bounds
        gradient.colors = gradientSet[currentGradient]
        gradient.startPoint = CGPoint(x:0, y:0)
        gradient.endPoint = CGPoint(x:1, y:1)
        gradient.drawsAsynchronously = true
        self.view.layer.addSublayer(gradient)
        
        animateGradient()
        setUpView()
        gestureRecognizer()
        
    }
    
    func animateGradient() {
        if currentGradient < gradientSet.count - 1 {
            currentGradient += 1
        } else {
            currentGradient = 0
        }
        
        let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
        gradientChangeAnimation.duration = 5.0
        gradientChangeAnimation.toValue = gradientSet[currentGradient]
        gradientChangeAnimation.fillMode = CAMediaTimingFillMode.forwards
        gradientChangeAnimation.isRemovedOnCompletion = false
        gradient.add(gradientChangeAnimation, forKey: "colorChange")
    }
    
}
//MARK: - Animation
extension ViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            gradient.colors = gradientSet[currentGradient]
            animateGradient()
        }
    }
}
