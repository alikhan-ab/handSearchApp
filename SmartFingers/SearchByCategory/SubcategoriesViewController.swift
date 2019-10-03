//
//  SubcategoriesViewController.swift
//  SmartFingers
//
//  Created by DCLab on 10/1/19.
//  Copyright © 2019 Aigerim Janaliyeva. All rights reserved.
//

import Foundation
import UIKit

class SubcategoriesViewController: UIViewController, UINavigationBarDelegate {
    
    var tableView   : UITableView!
    let navbar      = UINavigationBar(frame: CGRect(x: 0, y: 25, width: UIScreen.main.bounds.width, height: 75))
    var dataExample = ["Colours", "Measurements", "Emotions","Characteristics","Numbers","General: Time"]
    var navItem = UINavigationItem()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        view.backgroundColor = UIColor.white
        setupNavBar()
        setUpTableView()
    }

    func setUpTableView() {
        
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        let constraints:[NSLayoutConstraint] = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 75),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        tableView.register(NameCell.self, forCellReuseIdentifier: "cellID")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setupNavBar() {
        let height: CGFloat = 75
//        navbar.backgroundColor =  UIColor.white
        navbar.delegate = self
//        navItem.title =
        navItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(back))
        navbar.items = [navItem]
        view.addSubview(navbar)
        self.view.frame = CGRect(x: 0, y: height+25, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height - height-25))
    }

    @objc func back(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
}


extension SubcategoriesViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataExample.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = SignWordViewController()
        destination.navItem.title = dataExample[indexPath.row]
        self.present(destination, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! NameCell
        let name = dataExample[indexPath.row]
        cell.dayLabel.text = name
        return cell
    }
    
}
