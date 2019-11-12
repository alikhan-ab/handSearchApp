//
//  HandShapeVC.swift
//  SmartFingers
//
//  Created by DCLab on 11/7/19.
//  Copyright © 2019 Aigerim Janaliyeva. All rights reserved.
//

import Foundation
import UIKit

class HandShapeVC: UIViewController, UINavigationBarDelegate {
    
    //MARK:- Variables
    
    var navbar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 75))
    var navItem = UINavigationItem()
    let screenSize: CGRect = UIScreen.main.bounds
    
//    var cameraView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .darkGray
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(HandShapeImageCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    fileprivate let data = [
        CustomData(title: "The Islands!", url: "wiki", backgroundImage: #imageLiteral(resourceName: "sample1")),
        CustomData(title: "Sample", url: "wiki", backgroundImage: #imageLiteral(resourceName: "sample1")),
        CustomData(title: "Sample", url: "wiki", backgroundImage: #imageLiteral(resourceName: "sample3")),
        CustomData(title: "Sample Views!", url: "wiki", backgroundImage: #imageLiteral(resourceName: "sample1")),
        CustomData(title: "Sample", url: "wiki", backgroundImage: #imageLiteral(resourceName: "sample1")),
    ]
    
    let tableview: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor.white
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorColor = UIColor.white
        return tv
    }()
    
    //MARK:- Methods:
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setUpViews()
    }
    
    @objc func back(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func changeCamera(_ sender: UIButton){
        print("Open camera!")
        self.present(CameraVC(), animated: true, completion: nil)
    }
        
    func setUpViews() {
        
        //NavigationBar:
        navbar.backgroundColor = UIColor.white
        navbar.delegate = self
        navItem.title = "HandShape Recognition"
        navItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(back))
        let cameraItem = UIBarButtonItem(title: "Camera", style: .plain, target: self, action: #selector(changeCamera))
//        navItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "flip2"), style: .plain, target: self, action: #selector(changeCamera))
        //UIBarButtonItem(title: "Change camera", style: .plain, target: self, action: #selector(changeCamera))//#selector(signToLetter))
//        UIBarButtonItem(image: UIImage(named: "camera_flip"), style: .plain, target: self, action: #selector(changeCamera))
        
//        let negativeSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
//        negativeSpacer.width = 50
//
//        navItem.rightBarButtonItems = [negativeSpacer, cameraItem]
        navItem.rightBarButtonItem = cameraItem
        
        navbar.items = [navItem]
        view.addSubview(navbar)
        NSLayoutConstraint.activate([
            navbar.topAnchor.constraint(equalTo: self.view.topAnchor),
            navbar.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            navbar.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            navbar.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
        self.view.frame = CGRect(x: 0, y: 75, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height - 75))
        
        //Camera:
//        view.addSubview(cameraView)
//        let cameraHeight = screenSize.height*0.4
//        NSLayoutConstraint.activate([
//            cameraView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 75),
//            cameraView.heightAnchor.constraint(equalToConstant: cameraHeight),
//            cameraView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
//            cameraView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
//        ])
        
        //CollectionView:
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 75).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: view.frame.width/3).isActive = true
        
        //TableView:
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(HandShapeVideoCell.self, forCellReuseIdentifier: "cellId")
        view.addSubview(tableview)
        
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            tableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableview.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableview.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
        
        
    }
    
    func showActionSheet(controller: UIViewController, indexPath: IndexPath) {
        let alert = UIAlertController(title: "Title", message: "\(indexPath.row)", preferredStyle: .actionSheet)
//        alert.addAction(UIAlertAction(title: "Approve", style: .default, handler: { (_) in
//            print("User click Approve button")
//        }))
        
//        alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: { (_) in
//            print("User click Edit button")
//        }))
        
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (_) in
            print("User click Delete button")
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { (_) in
            print("User click Dismiss button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    
    
}


// MARK: - UICollectionView Delegate
extension HandShapeVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/3)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HandShapeImageCell
        cell.data = self.data[indexPath.item]
        return cell
    }
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        showActionSheet(controller: self, indexPath: indexPath)
        
//        performSegue(withIdentifier: "showDetail", sender: cell)
    }
    
}

// MARK: - UITableView Delegate
extension HandShapeVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15//allPlayers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 2
        let cell = tableview.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! HandShapeVideoCell
        //        let candy: Footballer
        //        if filteredFootballer.isEmpty {
        //            candy = allPlayers[indexPath.row]
        //        } else {
        //            candy = filteredFootballer[indexPath.row]
        //        }
        cell.nameLabel.text = "Sample video"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let destination = SignWordViewController()
        let name = "Sample"
        destination.navItem.title = name //tableView.cellForRow(at: indexPath)?.textLabel!.text
        self.present(destination, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
}

