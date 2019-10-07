//
//  SubcategoriesViewController.swift
//  SmartFingers
//
//  Created by DCLab on 10/1/19.
//  Copyright © 2019 Aigerim Janaliyeva. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SubcategoriesViewController: UIViewController, UINavigationBarDelegate {
    
    var tableView   : UITableView!
    let navbar      = UINavigationBar(frame: CGRect(x: 0, y: 25, width: UIScreen.main.bounds.width, height: 75))
    var dataExample = ["Colours", "Measurements", "Emotions","Characteristics","Numbers","General: Time"]
    var navItem = UINavigationItem()
    
    var subcategory: String?
    private let persistentContainer = NSPersistentContainer(name: "SmartFingers")

    lazy var fetchedResultsController: NSFetchedResultsController<Word> = {
        
        let fetchRequest: NSFetchRequest<Word> = Word.fetchRequest()
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "translation", ascending: true)]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        persistentContainer.loadPersistentStores { (NSPersistentStoreDescription, error) in
            if let error = error {
                print("Unable to Load Persistent Store")
                print("\(error), \(error.localizedDescription)")
            } else {
                do {
                    guard let subcategory = self.subcategory else {
                        fatalError()
                    }
                    self.fetchedResultsController.fetchRequest.predicate = NSPredicate(format: "from.name = %@", subcategory)
                    try self.fetchedResultsController.performFetch()
                } catch {
                    let error = error as NSError
                    print("\(error), \(error.localizedDescription)")
                }
            }
        }
        
        self.hideKeyboardWhenTappedAround()
        self.view.backgroundColor = UIColor.white
        self.setupNavBar()
        self.setUpTableView()
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
        navItem.title = subcategory
        view.addSubview(navbar)
        self.view.frame = CGRect(x: 0, y: height+25, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height - height-25))
        navItem.title = subcategory
    }

    @objc func back(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
}


extension SubcategoriesViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let words = fetchedResultsController.fetchedObjects else {return 0}
        return words.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = SignWordViewController()        
        let word = fetchedResultsController.object(at: indexPath)
        destination.word = word
        self.present(destination, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! NameCell
        
        let word = fetchedResultsController.object(at: indexPath)
        cell.dayLabel.text = word.translation
        return cell
    }
    
}

extension SubcategoriesViewController: NSFetchedResultsControllerDelegate {}
